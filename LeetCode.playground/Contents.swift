import UIKit


//Question - https://leetcode.com/problems/two-sum/
struct TwoSums {
    static let nums = [2, 7, 11, 15]
    static let target = 18
    static func findTwoSums(nums: [Int], target:Int) -> [Int] {
        //maintain map of Value and index, check if the difference value exist
        var map = [Int: Int]()
        var result = [Int]()
        
        for i in 0...(nums.count-1) {
            map[nums[i]] = i
        }
        
        for i in 0...(nums.count-1) {
            let diff = target - nums[i]
            if let mapIndex = map[diff] {
                //found the result
                result.append(i)
                result.append(mapIndex)
                break
            }
        }
        
        return result
    }
}

let result = TwoSums.findTwoSums(nums: TwoSums.nums, target: TwoSums.target)
print("Two Sums Result: \(result)")


/**
 * Definition for singly-linked list.
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    //function to print linked list
    static func printLinkedList(head: ListNode?) {
        var curr: ListNode? = head
        while(curr != nil) {
            if let v = curr?.val {
                print(v)
            }
            
            curr = curr?.next
        }
    }
}

class TwoNumbers {
    static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l3: ListNode? = ListNode(0)
        var i1 = l1
        var i2 = l2
        var i3 = l3
        var carryForward = 0
        while (i1 != nil || i2 != nil) {
            
            var v1 = 0
            var v2 = 0
            if let v = i1?.val {
                v1 = v
            }
            
            if let v = i2?.val {
                v2 = v
            }
            
            var sum = v1 + v2 + carryForward
            carryForward = 0
            if(sum > 9) {
                carryForward = 1
                sum = sum - 10
            }
            
            i3?.next = ListNode(sum)
            
            //iterate everything
            i3 = i3?.next
            i1 = i1?.next
            i2 = i2?.next
        }
        
        if (carryForward > 0) {
            i3?.next = ListNode(carryForward)
        }
        
        return l3?.next
    }
}

var l1 = ListNode(1) // 1, 8
l1.next = ListNode(8)
var l2 = ListNode(0) // 0

let twoNumberResult = TwoNumbers.addTwoNumbers(l1, l2) //expected 1, 8
print("Two Numbers Results:")
ListNode.printLinkedList(head: twoNumberResult)

