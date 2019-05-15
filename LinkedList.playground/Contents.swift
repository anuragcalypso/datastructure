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

func addAtPostion(head: Node?, val: Int, pos: Int) -> Node? {
    if let h = head {
        var curr: Node? = h
        for _ in 0...pos {
            curr = curr?.next
        }
        
        if let c = curr {
            let newNode = Node(val)
            let temp = c.next
            c.next = newNode
            newNode.next = temp
        }
    }
    
    return head
}

func insertALoopInLinkedList(head: Node?, pos: Int) -> Node? {
    if let h = head {
        var curr: Node? = h
        var node: Node?
        var i = 0
        while(curr != nil) {
            //save node if we reached the postion
            if i == pos {
                node = curr
            }
            
            curr = curr?.next
            if(curr?.next == nil) {
                //we reached the end of the list, insert the saved node in the list
                curr?.next = node
                break
            }
            
            i += 1
        }
    }
    
    return head
}

func loopCheckForLinkedList(head: Node?) -> Bool {
    var result = false
    
    if let h = head {
        var slow: Node? = h
        var fast: Node? = h.next
        var i = 0
        while(true) {
            if (slow == nil || fast == nil) {
                //no loop in the list, break the loop
                break
            }
            
            if fast?.data == slow?.data {
                result = true
                break
            }
            
            if i == 2 {
                slow = slow?.next
                i = 0
            }
            
            fast = fast?.next
            i += 1
            
            print("Fast \(fast?.data ?? -1) Slow \(slow?.data ?? -1) i \(i)")
        }
    }
    
    return result
}

//Create Linked List
var head = createLinkedList(length: 10)
printLinkedList(head: head)

//Reverse Linked List
let revHead = reverseLinkedList(head: head)
printLinkedList(head: revHead)

//Loop Check
head = insertALoopInLinkedList(head: head, pos: 2)
let isLoopExist = loopCheckForLinkedList(head: head)
print("Does Loop Exist: \(isLoopExist)")
