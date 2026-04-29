# CHECKLIST

This checklist is maintained alongside development to track topic coverage.

Some items may be incomplete, partially implemented, or not yet reviewed.

## Extensions
<!--- [ ] Extension Syntax-->
- [x] Computed Properties
- [x] Initializers
- [x] Methods
  - [x] Mutating Instance Methods
- [x] Subscripts
- [ ] Nested Types

## Protocols    
<!--- [ ] Protocol Syntax-->
- [x] Property Requirements
- [x] Method Requirements
- [ ] Mutating Method Requirements
- [ ] Initializer Requirements
  - [ ] Class Implementations of Protocol Initializer Requirements
  - [ ] Failable Initializer Requirements
- [x] Protocols that Have Only Semantic Requirements (Sendable, Codable)
- [x] Protocols as Types
- [x] Delegation
- [x] Adding Protocol Conformance with an Extension (UUID+,String+Extensions)
  - [x] Conditionally Conforming to a Protocol
  - [ ] Declaring Protocol Adoption with an Extension
- [x] Adopting a Protocol Using a Synthesized Implementation
- [x] Implicit Conformance to a Protocol (Copyable, Sendable, BitwiseCopyable)
- [x] Collections of Protocol Types
- [x] Protocol Inheritance
- [x] Class-Only Protocols
- [x] Protocol Composition
- [x] Checking for Protocol Conformance
- [ ] Optional Protocol Requirements (@objc protocols)
- [x] Protocol Extensions
  - [x] Providing Default Implementations
  - [ ] Adding Constraints to Protocol Extensions

## Generics
<!--- [ ] The Problem that Generics Solve-->
- [x] Generic Functions
- [x] Type Parameters
<!--- [ ] Naming Type Parameters-->
<!--- [ ] Generic Types-->
- [ ] Extending a Generic Type
- [x] Type Constraints
  <!--- [ ] Type Constraint Syntax-->
  <!--- [ ] Type Constraints in Action-->
- [x] Associated Types
  - [x] Associated Types in Action
  - [ ] Extending an Existing Type to Specify an Associated Type
  - [x] Adding Constraints to an Associated Type
  - [x] Using a Protocol in Its Associated Type’s Constraints
- [x] Generic Where Clauses
- [x] Extensions with a Generic Where Clause
- [ ] Contextual Where Clauses
- [ ] Associated Types with a Generic Where Clause (น่าจะทำได้)
- [ ] Generic Subscripts
- [ ] Implicit Constraints

## Opaque and Boxed Protocol Types
<!--- [ ] The Problem that Opaque Types Solve-->
- [ ] Returning an Opaque Type
- [x] Boxed Protocol Types
<!--- [ ] Differences Between Opaque Types and Boxed Protocol Types-->
- [x] Opaque Parameter Types (generic shorthand)

## Automatic Reference Counting
<!--- [ ] How ARC Works-->
- [ ] ARC in Action
- [ ] Strong Reference Cycles Between Class Instances
- [ ] Resolving Strong Reference Cycles Between Class Instances
  - [x] Weak References
  - [ ] Unowned References
  - [ ] Unowned Optional References
  - [ ] Unowned References and Implicitly Unwrapped Optional Properties
- [ ] Strong Reference Cycles for Closures
- [ ] Resolving Strong Reference Cycles for Closures
  - [ ] Defining a Capture List
  - [ ] Weak and Unowned References

## Memory Safety
<!--- [ ] Understanding Conflicting Access to Memory
  - [ ] Characteristics of Memory Access-->
- [ ] Conflicting Access to In-Out Parameters
- [ ] Conflicting Access to self in Methods
- [ ] Conflicting Access to Properties

## Access Control

<!--- [ ] Modules, Source Files, and Packages-->
- [x] Access Levels
  <!--- [ ] Guiding Principle of Access Levels-->
  - [x] Default Access Levels
  - [x] Access Levels for Single-Target Apps
  - [x] Access Levels for Frameworks
  - [x] Access Levels for Unit Test Targets
<!--- [ ] Access Control Syntax-->
- [x] Custom Types
  - [ ] Tuple Types
  - [x] Function Types
  - [x] Enumeration Types
  - [x] Nested Types
- [ ] Subclassing
- [x] Constants, Variables, Properties, and Subscripts
  - [x] Getters and Setters
- [x] Initializers
  - [x] Default Initializers
  - [x] Default Memberwise Initializers for Structure Types
- [x] Protocols
  - [x] Protocol Inheritance
  - [ ] Protocol Conformance
- [ ] Extensions
  - [ ] Private Members in Extensions
- [x] Generics
- [x] Type Aliases

## Advanced Operators
- [ ] Bitwise Operators
  - [ ] Bitwise NOT Operator
  - [ ] Bitwise AND Operator
  - [ ] Bitwise OR Operator
  - [ ] Bitwise XOR Operator
  - [x] Bitwise Left and Right Shift Operators
- [ ] Overflow Operators
  - [ ] Value Overflow
- [ ] Precedence and Associativity
- [ ] Operator Methods
  - [ ] Prefix and Postfix Operators
  - [ ] Compound Assignment Operators
  - [ ] Equivalence Operators
- [ ] Custom Operators
  - [ ] Precedence for Custom Infix Operators
- [x] Result Builders
