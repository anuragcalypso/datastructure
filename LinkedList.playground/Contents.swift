import Foundation

//Declear the Node struture

class Node {
    var data: Int?
    var next: Node?
    init(_ value: Int) {
        data = value
    }
}

//create linked list of lenght n
func createLinkedList(length: Int) -> Node? {
    var head: Node?
    if length > 0 {
        head = Node(0)
        var curr = head
        for i in 1...length {
            curr?.next = Node(i)
            curr = curr?.next
        }
    }
    
    return head
}

//function to print linked list
func printLinkedList(head: Node?) {
    var curr: Node? = head
    while(curr != nil) {
        if let c = curr?.data {
            print(c)
        }
        
        curr = curr?.next
    }
}

//reverses linked list
func reverseLinkedList(head: Node?) -> Node? {
    var curr: Node? = head
    var prev: Node? = nil
    var next: Node? = head?.next
    head?.next = nil
    curr = next
    prev = head
    while (curr != nil) {
        next = curr?.next
        curr?.next = prev
        prev = curr
        curr = next
    }
    
    return prev
}

let head = createLinkedList(length: 5)
printLinkedList(head: head)
let revHead = reverseLinkedList(head: head)
printLinkedList(head: revHead)
