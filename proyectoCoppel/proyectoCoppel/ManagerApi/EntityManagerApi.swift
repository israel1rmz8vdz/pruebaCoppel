//
//  EntityManagerApi.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 05/03/23.
//

import Foundation
/**
 Enumeración para lo métodos http.
 */
public enum ApiMethod: String {
    ///Solicita una representación del recurso especifico.
    case get = "GET"
    ///Envia una entidad a un recurso en especifico.
    case post = "POST"
    ///Reemplaza todas las representaciones actuales del recurso en especifico.
    case put = "PUT"
    ///Borra un recurso en especifico.
    case delete = "DELETE"
    ///Solicita una representación del recurso pero sin el cuerpo de respuesta.
    case head = "HEAD"
    ///Establece un túnel hacia el servidor especificado.
    case connect = "CONNECT"
    ///Describe las opciones de comunicación para el recurso de destino.
    case options = "OPTIONS"
    ///Realiza una prueba de bucle de retorno de mensaje a lo largo de la ruta del destino.
    case trace = "TRACE"
    ///Es utilizado para aplicar modificaciones parciales a un recurso.
    case patch = "PATCH"
}
public extension Encodable {
    /// Convierte a formato JSON String.
    var toJSONString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    /// Convierte a objecto Data.
    var toData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        do {
            let jsonData = try encoder.encode(self)
            return jsonData
        } catch {
            return nil
        }
    }
}
internal protocol ClassDescribing {
    /// Nombre de la clase
    static var className: String { get }
}
extension ClassDescribing {
    static var className: String {
        return String.init(describing: self)
    }
}
