# DribbbleKit
===========

DribbbleKit is a modern Objective-C framework for implementing Dribbble API on iOS. It's RESTFull is based on RestKit.

## Quick start
===========
In your Terminal type:
```
$ cd [your project directory]
$ clone https://github.com/0day2010/DribbbleKit.git
$ git submodule update --init
```

You can run Demo project when git clone and submodule update complete.

You will find out there is one APIEngine, you can send all your Dribbble request through it.
```
// Access to APIEngine
DKAPIEngine *apiEngine = [DKAPIEngine sharedEngine];
```
```
// Get a Player
[apiEngine playerWithPlayerID:@"misu"
                      success:^(DKPlayer *player){
                          NSLog(@"%@", player);
                      }
                      failure:^(NSError *error){
                          NSLog(@"%@", error);
                      }];
```
```
// Get most recent shots by the player
[apiEngine recentShotsByPlayer:player
                collectionInfo:nil
                       success:^(DKShots *shots){
                           NSLog(@"%@", shots);
                       }
                       failure:^(NSError *error){
                           NSLog(@"%@", error);
                       }];

```

## Requirement
===========
* [RestKit](https://github.com/RestKit/RestKit)

## Donate
===========
You can donate me
via:
* [Alipay | 支付宝](https://me.alipay.com/0dayzh)

## License
===========
This code is distributed under the terms of the GNU General Public License.
