//
//  managerConection.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 05/03/23.
//
import Foundation
/**
 Protocolo para el envío de información hacia Interactor.
 */
public protocol ApiServiceDelegate {
    /**
     Función que envía la información del servidor.
     - parameter data: Es la información obtenida del servicio.
     - parameter serviceName: Es el identificador del servicio de tipo cadena.
     */
    func didReceiveData(data: Data, serviceName: String)
    /**
     Función que envía la información del servidor, cuando sucede un error.
     - parameter error: Es el error obtenido del servicio.
     - parameter data: Es la información obtenida del servicio.
     - parameter serviceName: Es el identificador del servicio de tipo cadena.
     */
    func didReceiveError(error: Error?, data: Data?, serviceName: String)
}
final class APIManager {
    static let shared = APIManager()
    private var session: URLSession
    private init() {
        session = .shared
    }
    public var delegate: ApiServiceDelegate?
    enum APIManagerError: Error {
        case invalidResponse(Data?, URLResponse?)
        case loginFailed(String)
    }
    /**
    Función encargada de consumir el servicio mediante una urlSession
     - Parameters:
        - url: Url del servicio
        - methodApi: Metodo https [get,post,delete,update,patch]
        - entityBody: entidad para un request
        - serviceName: Identificador para el servicio que mandamos a llamar
     */
    func prepareApiRequest(url: String, methodApi: ApiMethod, entityBody: Data?, serviceName: String) {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        session = URLSession(configuration: config)
        
        guard let urlValidate = URL(string: url) else { return }
        var urlRequest: URLRequest = URLRequest(url: urlValidate)
        urlRequest.httpMethod = methodApi.rawValue
        if methodApi == .post {
            urlRequest.httpBody = entityBody
        }
        #if DEBUG
        dump(entityBody?.toData)
        #endif
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                self.delegate?.didReceiveError(error: error, data: data, serviceName: serviceName)
                return
            }
            guard let content = data else {
                self.delegate?.didReceiveError(error: error, data: data, serviceName: serviceName)
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                return
            }
            DispatchQueue.main.async {
                self.delegate?.didReceiveData(data: content, serviceName: serviceName)
            }
            #if DEBUG
            print("gotten json response dictionary is \n \(json)")
            #endif
        }
        task.resume()
    }
    public func decode<T: Codable>(_ type: T.Type, from data: Data) -> T? {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                #if DEBUG
                print(error)
                #endif
            }
            return nil
        }
}
