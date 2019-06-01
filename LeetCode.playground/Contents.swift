import UIKit

extension String {
    func subString(_ range: CountableRange<Int>) -> String {
        /*
         let s = "hello"
         s[0..<3] // "hel"
         s[3..<s.count] // "lo"
         */
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
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

//let result = TwoSums.findTwoSums(nums: TwoSums.nums, target: TwoSums.target)
//print("Two Sums Result: \(result)")


/**
 * Definition for singly-linked list.
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        let x = [Int]()
        
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

//var l1 = ListNode(1) // 1, 8
//l1.next = ListNode(8)
//var l2 = ListNode(0) // 0

//let twoNumberResult = TwoNumbers.addTwoNumbers(l1, l2) //expected 1, 8
//print("Two Numbers Results:")
//ListNode.printLinkedList(head: twoNumberResult)


//https://leetcode.com/problems/longest-palindromic-substring/
/*
 Input: "babad"
 Output: "bab"
 */

class Palindrome {
    static func longestPalindrome(_ s: String) -> String {
        var result = s
        let n = s.lengthOfBytes(using: .utf8) //length of string
        if n > 1 {
            var maxLenght = 1
            var start = 0
            
            //table for storing values
            var table = Array(repeating: Array(repeating: false, count: n), count: n)
            
            //all the elements with length 1 is palindrome
            for i in 0...n-1 {
                table[i][i] = true
            }
            
            //check for elements of length 2
            for i in 0...n-2 {
                let value1 = s.subString(i..<i+1)
                let j = i+1
                let value2 = s.subString(j..<j+1)
                /*
                 s = "ac"
                 i = 0, v1 = 0..1 = a
                 j = 1, v2 = 0..2 = ac
                 */
                
                if(value1.caseInsensitiveCompare(value2) == .orderedSame) {
                    table[i][i+1] = true
                    maxLenght = 2
                    start = i
                }
            }
            
            //check for length greater than 2
            if(n > 2) {
                for k in 3...n {
                    for i in 0...n-k+1 {
                        let j = i+k-1
                        let value1 = s.subString(i..<i+1)
                        let value2 = s.subString(j..<j+1)
                        if(table[i+1][j-1] && (value1.caseInsensitiveCompare(value2) == .orderedSame)) {
                            table[i][j] = true
                            if k > maxLenght {
                                maxLenght = k
                                start = i
                            }
                        }
                    }
                }
            }
            
            
            let end = start + maxLenght
            result = s.subString(start..<end)

        }
        return result
    }
}

class PalindromeAlternate {
    static func findPalindrome(_ arr: Array<Character>, left: Int, right: Int) -> String {
        var leftIndex = left
        var rightIndex = right
        while leftIndex >= 0 && rightIndex < arr.count {
            if arr[leftIndex] != arr[rightIndex] {
                break
            }
            leftIndex -= 1
            rightIndex += 1
        }
        return String(arr[leftIndex + 1..<rightIndex])
    }
    
    static func longestPalindrome(_ s: String) -> String {
        var result = String()
        var palindrome = String()
        let arr: Array<Character> = Array(s)
        var index = 0
        
        while index < arr.count {
            if result.count >= (arr.count - index) * 2 {
                break
            }
            
            palindrome = PalindromeAlternate.findPalindrome(arr, left: index, right: index)
            if palindrome.count > result.count {
                result = palindrome
            }
            
            palindrome = findPalindrome(arr, left: index, right: index + 1)
            if palindrome.count > result.count {
                result = palindrome
            }
            index += 1
        }
        return result
    }
}

//let palindromeResult = Palindrome.longestPalindrome("civilwartestingwhetherthatnaptionoranynartionsoconceivedandsodedicatedcanlongendureWeareqmetonagreatbattlefiemldoftzhatwarWehavecometodedicpateaportionofthatfieldasafinalrestingplaceforthosewhoheregavetheirlivesthatthatnationmightliveItisaltogetherfangandproperthatweshoulddothisButinalargersensewecannotdedicatewecannotconsecratewecannothallowthisgroundThebravelmenlivinganddeadwhostruggledherehaveconsecrateditfaraboveourpoorponwertoaddordetractTgheworldadswfilllittlenotlenorlongrememberwhatwesayherebutitcanneverforgetwhattheydidhereItisforusthelivingrathertobededicatedheretotheulnfinishedworkwhichtheywhofoughtherehavethusfarsonoblyadvancedItisratherforustobeherededicatedtothegreattdafskremainingbeforeusthatfromthesehonoreddeadwetakeincreaseddevotiontothatcauseforwhichtheygavethelastpfullmeasureofdevotionthatweherehighlyresolvethatthesedeadshallnothavediedinvainthatthisnationunsderGodshallhaveanewbirthoffreedomandthatgovernmentofthepeoplebythepeopleforthepeopleshallnotperishfromtheearth")
//print("palindromeResult: \(palindromeResult)")

//Question - https://leetcode.com/problems/merge-two-sorted-lists/

class MergeTwoSortedLinkedList {
    static func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let head = ListNode(0)
        
        //base conditions
        if l1 == nil {
            head.next = l2
        } else if l2 == nil {
            head.next = l1
        } else {
            //merge two valid linked list
            var i1 = l1
            var i2 = l2
            var i3: ListNode? = head
            
            while (true) {
                if(i1 == nil || i2 == nil) {
                    i3?.next = i1 == nil ? i2 : i1
                    break
                }
                
                var v1 = 0
                var v2 = 0
                if let v = i1?.val {
                    v1 = v
                }
                
                if let v = i2?.val {
                    v2 = v
                }
                
                if (v1 < v2) {
                    i3?.next = ListNode(v1)
                    i1 = i1?.next
                } else if v1 > v2 {
                    i3?.next = ListNode(v2)
                    i2 = i2?.next
                } else {
                    //v1 == v2
                    i3?.next = ListNode(v1)
                    i3?.next?.next = ListNode(v1)
                    i3 = i3?.next
                    //iterate everting
                    i1 = i1?.next
                    i2 = i2?.next
                }
                
                i3 = i3?.next
            }
            
        }
        
        return head.next
    }
}

/*
 var l1 = ListNode(2)
 l1.next = ListNode(2)
 l1.next?.next = ListNode(4)
 
 var l2 = ListNode(1)
 l2.next = ListNode(3)
 l2.next?.next = ListNode(4)
 let head = MergeTwoSortedLinkedList.mergeTwoLists(l1, l2)
 print("Merged Linked List Results:")
 ListNode.printLinkedList(head: head)

 */

//i + (i+1) + j + (j-1) + k
func getSequenceSum(i: Int, j: Int, k: Int) -> Int {
    var sum: Int = 0
    
    var q = i
    while(q != j) {
        sum += i + q
        if q > j {
            q = q - 1
        }
        
        if q < j {
            q = q + 1
        }
    }
    
    
    
    var p = j
    while(p != k) {
        sum += j - p
        if p > k {
            p = p - 1
        }
        
        if p < k {
            p = p + 1
        }
    }
    
    sum += k
    
    return sum
}

//print(getSequenceSum(i: -5, j: -1, k: -3))

 //0 + 1 + 1


//Question:

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//Symmetric Tree

class Symmetric {
    
    func inorder(_ root: TreeNode?) {
        if let root = root {
            inorder(root.left)
            print(root.val)
            inorder(root.right)
        } else {
            return
        }
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return mirror(root, n2: root)
    }
    
    func mirror( _ n1: TreeNode?, n2: TreeNode?) -> Bool {
        if n1 == nil && n2 == nil {
            return true
        }
        
        if (n1?.val == n2?.val && mirror(n1?.left, n2: n2?.right) && mirror(n1?.right, n2: n2?.left)) {
            return true
        }
        
        return false
    }
    
    
    func traverseBFS(q: Queue) {
        if let element = q.dequeue() {
            print(element.val)
            q.enqueue(element.left)
            q.enqueue(element.right)
            traverseBFS(q: q)
        }
    }
}

class BFS {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var currentLevel: [TreeNode] = [TreeNode]()
        var result = [[Int]]()
        if let root = root {
            currentLevel.append(root)
        }
        
        return processCurrentLevel(currentLevel, result: result)
    }
    
    func processCurrentLevel(_ level: [TreeNode], result: [[Int]]) -> [[Int]] {
        var r = result
        var levelValues: [Int] = [Int]()
        var nextLevel: [TreeNode] = [TreeNode]()
        level.forEach { (node) in
            levelValues.append(node.val)
            if let left = node.left {
                nextLevel.append(left)
            }
            
            if let right = node.right {
                nextLevel.append(right)
            }
        }
        
        r.append(levelValues)
        
        if nextLevel.count > 0 {
            return processCurrentLevel(nextLevel, result: r)
        } else {
            return r
        }
    }
}

class Queue {
    var items: [TreeNode] = [TreeNode]()
    init(_ values: [TreeNode]?) {
        if let values = values {
            self.items = values
        }
    }
    
    func enqueue(_ value: TreeNode?) {
        if let val = value {
            items.append(val)
        }
    }
    
    func dequeue() -> TreeNode? {
        var value: TreeNode? = nil
        if let first = items.first {
            value = first
            items.removeFirst()
        }
        
        return value
    }
}


class ReverseNumber {
    static func reverse(_ x: Int) -> Int {
        var result = 0
        let isNegative = (x < 0)
        let val = abs(x)
        var valStr = "\(val)"
        valStr = String(valStr.reversed())
        
        if let newVal = Int(valStr) {
            result = newVal
        }
        
        return result
    }
}

//print(ReverseNumber.reverse(123))


class PalindromeNumber {
    static func isPalindrome(x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        if x < 10 {
            return true
        }
        
        var div = 1
        while x / div >= 10 {
            div *= 10
        }
        
        var inputValue = x
        while inputValue > 0 {
            let l = inputValue / div //= 1
            let r = inputValue % 10  //= 1
            if l != r {
                return false
            }
            
            inputValue = (inputValue % div) / 10
            div /= 100
        }
        
        return true
    }
}

//print(PalindromeNumber.isPalindrome(x: 1001))


class RomanToString {
    static func romanToInt(_ s: String) -> Int {
        let chars = [Character](s)
        var sum = 0
        
        var valueMap: [String: Int] = [:]
        valueMap["I"] = 1
        valueMap["V"] = 5
        valueMap["X"] = 10
        valueMap["L"] = 50
        valueMap["C"] = 100
        valueMap["D"] = 500
        valueMap["M"] = 1000
        
        var lastVal = 0
        chars.forEach { (char) in
            if let val = valueMap[String(char)] {
                if val <= lastVal {
                    sum += val
                } else {
                    sum = sum + (val - lastVal)
                    sum = sum - lastVal
                }
                
                lastVal = val
            }
        }
        
        return sum
    }
}


//print(RomanToString.romanToInt("IV"))

//Remove nth from Linked List
class LinkedListProblems {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head == nil {
            return head
        }
        
        var curr = head
        if curr?.next == nil, n == 1 {
            curr = nil
            return curr
        }
        
        let node = ListNode(0)
        var fast: ListNode? = node
        var slow: ListNode? = node
        var prev: ListNode? = node
        var counter = 0
        
        node.next = head
        
        
        while fast != nil {
            fast = fast?.next
            if counter == n {
                prev = slow
                slow = slow?.next
            } else {
                counter += 1
            }
        }
        
        if slow != nil {
            prev?.next = slow?.next
        }
        
        return node.next
    }
    
    static func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let h = head else {
            return head
        }
        
        var curr: ListNode? = h
        while curr != nil {
            if let tmp = curr?.val, let nextVal = curr?.next?.val {
                curr?.val = nextVal
                curr?.next?.val = tmp
            }
            
            curr = curr?.next?.next
        }
        
        return h
    }
}

/*
    var head = ListNode(1)
    head.next = ListNode(2)
    head.next?.next = ListNode(3)
    head.next?.next?.next = ListNode(4)
    ListNode.printLinkedList(head: head)

    let newHead = LinkedListProblems.swapPairs(head)
    ListNode.printLinkedList(head: newHead)
*/

class RemoveDuplicates {
    static var nums = [1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4,4]
    static func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        
        //maintain a valid counter
        var count = 1
        for i in 1..<nums.count {
            if nums[i] != nums[i-1] {
                nums[count] = nums[i]
                count += 1
            }
            print(nums)
        }
        
        return count
    }
    
    static func testRemoveDuplicate() {
        let _ = RemoveDuplicates.removeDuplicates(&nums)
        print(nums)
    }
}

//RemoveDuplicates.testRemoveDuplicate()

class MaxSubArray {
    static func maxSubArray(_ nums: [Int]) -> Int {
        var m = 0
        var result = Int.min
        for i in 0..<nums.count {
            m = max(nums[i], nums[i] + m)
            result = max(result, m)
        }
        
        return result
    }
}

//print(MaxSubArray.maxSubArray([-2,1,-3,4,-1,2,1,-5,4]))

class MergeTwoSorted {
    //[-1,1,1,1,2,3]
    static var nums = [0,0,3,0,0,0,0,0,0]
    static func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var index = m + n - 1
        var n1 = m - 1
        var n2 = n - 1
        
        while n1 >= 0 && n2 >= 0 {
            print("\(n1)  \(n2)  \(nums1[n1])  \(nums2[n2])")
            print(nums1)
            if(nums1[n1] >= nums2[n2]) {
                nums1[index] = nums1[n1];
                index -= 1
                n1 -= 1
            } else {
                nums1[index] = nums2[n2];
                index -= 1
                n2 -= 1
            }
        }
        
        while n2 >= 0 {
            nums1[index] = nums2[n2];
            index -= 1
            n2 -= 1
        }
    }
    
    static func testMerge() {
        MergeTwoSorted.merge(&nums, 3, [-1,1,1,1,2,3], 6)
        print(nums)
    }
}

//MergeTwoSorted.testMerge()

class ReverseString {
    static func reverseWords(_ s: String) -> String {
        var nParts = s.split(separator: " ")
        nParts = nParts.reversed()
        var result = ""
        nParts.forEach { (el) in
            result = result + " " + el.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func reverseWords2(_ s: String) -> String {
        let characters = Array(s)
        var result = ""
        
        var wordStarted = false
        var currentWord = ""
        for i in stride(from: characters.count - 1, to: -1, by: -1) {
            let currentChar = characters[i]
            if currentChar == " " {
                if wordStarted {
                    wordStarted = false
                    if result.count == 0 {
                        result = currentWord
                    } else {
                        result = result + " " + currentWord
                    }
                    
                    currentWord = ""
                }
            } else {
                if !wordStarted {
                    wordStarted = true
                }
                
                currentWord.insert(currentChar, at: currentWord.startIndex)
            }
        }
        
        if currentWord.count > 0 {
            if result.count == 0 {
                result = currentWord
            } else {
                result = result + " " + currentWord
            }
        }
        
        return result
    }
}

//print(ReverseString.reverseWords("a"))



class SpiralMatrix {
    static func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        
        var result = [Int]()
        
        if matrix.count == 0 || matrix[0].count == 0 {
            return result
        }
        
        var rowStart = 0
        var rowEnd = matrix.count - 1
        var colStart = 0
        var colEnd = matrix[0].count - 1
        
        
        while(rowStart <= rowEnd && colStart <= colEnd) {
            for i in stride(from: colStart, through: colEnd, by: 1) {
                result.append(matrix[rowStart][i])
            }
            
            rowStart += 1
            for i in stride(from: rowStart, through: rowEnd, by: 1) {
                result.append(matrix[i][colEnd])
            }
            
            colEnd -= 1
            
            if rowStart <= rowEnd {
                for i in stride(from: colEnd, through: colStart, by: -1) {
                    result.append(matrix[rowEnd][i])
                }
                
                rowEnd -= 1
            }
            
            if colStart <= colEnd {
                for i in stride(from: rowEnd, through: rowStart, by: -1) {
                    result.append(matrix[i][colStart])
                }
                
                colStart += 1
            }
        }
        
        return result
    }
}

let x = SpiralMatrix.spiralOrder([[[1,2,3],[4,5,6],[7,8,9]]])
print(x)
