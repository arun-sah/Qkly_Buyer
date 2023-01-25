//
//  CacheError.swift
//  QklyBuyer
//
//  Created by arun sah on 18/01/2023.
//


import Foundation

public enum CacheError: LocalizedError {
    
    /** Everything is good **/
    case none
    
    /** Entity with the name was not found **/
    case invalidEntity(entityName: String)
    
    /** Indicate that system throws the error **/
    case failure(Error)
    
    /** Context not provided **/
    case missingContext
    
    /** The dictionary has no class attribute **/
    case missingConstraint
    
    /** Provided data is not a dictionary or Array **/
    case invalidDataStructure
    
    /// The description of the error
    public var description: String {
        switch self {
            case .invalidEntity(let entityName):
                return "Invalid entity with name \"\(entityName)\""
            case .none:
                return ""
            case .failure(let error):
                return error.localizedDescription
            case .missingContext:
                return "Context not provided"
            case .missingConstraint:
                return "The dictionary provided doesn't have the required constraint key"
            case .invalidDataStructure:
                return "The provided data is not in valid format. It should be either a Dictionary or an Array"
        }
    }
}
