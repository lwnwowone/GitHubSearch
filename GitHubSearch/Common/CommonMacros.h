//
//  CommonMacros.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h


#endif /* CommonMacros_h */


#define __TO_WEAK(__VAR__) \
__weak __typeof__(__VAR__) __VAR__##__WEAK__ = (__VAR__);

#define __TO_STRONG(__VAR__) \
__strong __typeof__(__VAR__##__WEAK__) (__VAR__) = __VAR__##__WEAK__;

#define __TO_WEAK_SELF __TO_WEAK(self)
#define __TO_STRONG_SELF __TO_STRONG(self)
