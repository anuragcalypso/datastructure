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

