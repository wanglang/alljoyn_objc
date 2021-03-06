////////////////////////////////////////////////////////////////////////////////
// Copyright 2013, Qualcomm Innovation Center, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <alljoyn/Status.h>

/**
 * Access to status and error codes for AllJoyn
 */
@interface AJNStatus : NSObject

/**
 * Convert a status code to a string.
 *
 * QCC_StatusText(ER_OK) returns the string "ER_OK"
 *
 * @param status    Status code to be converted.
 *
 * @return  string representation of the status code.
 */
+ (NSString *)descriptionForStatusCode:(QStatus)status;

@end
