//
//  main.m
//  arrays
//
//  Created by Ricardo Nazario on 6/8/16.
//  Copyright © 2016 Ricardo Nazario. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        int n;
        scanf("%i",&n);
        int arr[n];
        int indexInt = 0;
        int sum;
    
        for(int arr_i = 0; arr_i < n; arr_i++){
            scanf("%d",&arr[arr_i]);
            sum = indexInt += arr[arr_i];
        }
        NSLog(@"%i", sum);
    }
    return 0;
}
