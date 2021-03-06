//
//  MPAutotypeCommand.m
//  MacPass
//
//  Created by Michael Starke on 10/11/13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "MPAutotypeCommand.h"
#import "NSString+Commands.h"

#import <Carbon/Carbon.h>

NSString *const kMPAutotypeSymbolShift = @"+";
NSString *const kMPAutotypeSymbolControl = @"^";
NSString *const kMPAutotypeSymbolAlt = @"%";
NSString *const kMPAutotypeSymbolEnter = @"~";
NSString *const kMPAutptypeCommandEnter = @"{ENTER}";
NSString *const kMPAutotypeCommandTab = @"{TAB}";
NSString *const kMPAutotypeCommandUp = @"{UP}";
NSString *const kMPAutotypeCommandDown = @"{DOWN}";
NSString *const kMPAutotypeCommandLeft = @"{LEFT}";
NSString *const kMPAutotypeCommandRight = @"{RIGHT}";
NSString *const kMPAutotypeCommandDelete = @"{DELETE}";
NSString *const kMPAutotypeCommandHome = @"{HOME}";
NSString *const kMPAutotypeCommandEnd = @"{END}";
NSString *const kMPAutotypeCommandPageUp = @"{PGUP}";
NSString *const kMPAutotypeCommandPageDown = @"{PGDOWN}";
NSString *const kMPAutotypeCommandBackspace = @"{BACKSPACE}";
NSString *const kMPAutotypeCommandBackspaceShort = @"{BS}";
NSString *const kMPAutotypeCommandBackspaceMedium = @"{BKSP}";
NSString *const kMPAutotypeCommandBreak = @"{BREAK}";
NSString *const kMPAutotypeCommandCapsLock = @"{CAPSLOCK}";
NSString *const kMPAutotypeCommandEscape = @"{ESC}";
NSString *const kMPAutotypeCommandWindows = @"{WIN}";
NSString *const kMPAutotypeCommandLeftWindows = @"{LWIN}";
NSString *const kMPAutotypeCommandRightWindows = @"{RWIN}";
NSString *const kMPAutotypeCommandApps = @"{APPS}";
NSString *const kMPAutotypeCommandHelp = @"{HELP}";
NSString *const kMPAutotypeCommandNumlock = @"{NUMLOCK}";
NSString *const kMPAutotypeCommandPrintScreen = @"{PRTSC}";
NSString *const kMPAutotypeCommandScrollLock = @"{SCROLLLOCK}";
NSString *const kMPAutotypeCommandF1 = @"{F1}";
/*
 Tab	{TAB}
Enter	{ENTER} or ~
Arrow Up	{UP}
Arrow Down	{DOWN}
Arrow Left	{LEFT}
Arrow Right	{RIGHT}
Insert	{INSERT} or {INS}
Delete	{DELETE} or {DEL}

 Home	{HOME}
End	{END}
Page Up	{PGUP}
Page Down	{PGDN}
Backspace	{BACKSPACE}, {BS} or {BKSP}
Break	{BREAK}
Caps-Lock	{CAPSLOCK}
Escape	{ESC}
Windows Key	{WIN} (equ. to {LWIN})
Windows Key: left, right	{LWIN}, {RWIN}
Apps / Menu	{APPS}
Help	{HELP}
Numlock	{NUMLOCK}
Print Screen	{PRTSC}
Scroll Lock	{SCROLLLOCK}
F1 - F16	{F1} - {F16}
Numeric Keypad +	{ADD}
Numeric Keypad -	{SUBTRACT}
Numeric Keypad *	{MULTIPLY}
Numeric Keypad /	{DIVIDE}
Numeric Keypad 0 to 9	{NUMPAD0} to {NUMPAD9}
Shift	+
Ctrl	^
Alt	%
+	{+}
^	{^}
%	{%}
~	{~}
(, )	{(}, {)}
        [, ]	{[}, {]}
                {, }	{{}, {}}
 */


@implementation MPAutotypeCommand

- (void)sendPressKey:(CGKeyCode)keyCode modifierFlags:(CGEventFlags)flags {
  CGEventRef pressKey = CGEventCreateKeyboardEvent (NULL, keyCode, YES);
  CGEventRef releaseKey = CGEventCreateKeyboardEvent (NULL, keyCode, NO);
  
  CGEventSetFlags(pressKey,0);
  CGEventSetFlags(releaseKey, 0);
  CGEventSetFlags(pressKey,flags);
  CGEventSetFlags(releaseKey, flags);
  
  CGEventPost(kCGSessionEventTap, pressKey);
  CGEventPost(kCGSessionEventTap, releaseKey);
  
  CFRelease(pressKey);
  CFRelease(releaseKey);
}

/*
 cody by Joe Turner http://www.cocoabuilder.com/archive/cocoa/242992-detect-keyboard-layout-for-cgkeycodes.html#243168
 */
- (CGKeyCode)keyCodeForKeyboard:(const UCKeyboardLayout *)uchrHeader character:(NSString *)character {
  if ([character isEqualToString:@"RETURN"]) return kVK_Return;
  if ([character isEqualToString:@"TAB"]) return kVK_Tab;
  if ([character isEqualToString:@"SPACE"]) return kVK_Space;
  if ([character isEqualToString:@"DELETE"]) return kVK_Delete;
  if ([character isEqualToString:@"ESCAPE"]) return kVK_Escape;
  if ([character isEqualToString:@"F5"]) return kVK_F5;
  if ([character isEqualToString:@"F6"]) return kVK_F6;
  if ([character isEqualToString:@"F7"]) return kVK_F7;
  if ([character isEqualToString:@"F3"]) return kVK_F3;
  if ([character isEqualToString:@"F8"]) return kVK_F8;
  if ([character isEqualToString:@"F9"]) return kVK_F9;
  if ([character isEqualToString:@"F11"]) return kVK_F11;
  if ([character isEqualToString:@"F13"]) return kVK_F13;
  if ([character isEqualToString:@"F16"]) return kVK_F16;
  if ([character isEqualToString:@"F14"]) return kVK_F14;
  if ([character isEqualToString:@"F10"]) return kVK_F10;
  if ([character isEqualToString:@"F12"]) return kVK_F12;
  if ([character isEqualToString:@"F15"]) return kVK_F15;
  if ([character isEqualToString:@"HELP"]) return kVK_Help;
  if ([character isEqualToString:@"HOME"]) return kVK_Home;
  if ([character isEqualToString:@"PAGE UP"]) return kVK_PageUp;
  if ([character isEqualToString:@"FORWARD DELETE"]) return kVK_ForwardDelete;
  if ([character isEqualToString:@"F4"]) return kVK_F4;
  if ([character isEqualToString:@"END"]) return kVK_End;
  if ([character isEqualToString:@"F2"]) return kVK_F2;
  if ([character isEqualToString:@"PAGE DOWN"]) return kVK_PageDown;
  if ([character isEqualToString:@"F1"]) return kVK_F1;
  if ([character isEqualToString:@"LEFT"]) return kVK_LeftArrow;
  if ([character isEqualToString:@"RIGHT"]) return kVK_RightArrow;
  if ([character isEqualToString:@"DOWN"]) return kVK_DownArrow;
  if ([character isEqualToString:@"UP"]) return kVK_UpArrow;
  
  UTF16Char theCharacter = [character characterAtIndex:0];
  long i, j, k;
  unsigned char *uchrData = (unsigned char *)uchrHeader;
  UCKeyboardTypeHeader *uchrTable = uchrHeader->keyboardTypeList;
  BOOL found = NO;
  UInt16 virtualKeyCode;
  
  for (i = 0; i < (uchrHeader->keyboardTypeCount) && !found; i++) {
    UCKeyToCharTableIndex *uchrKeyIX;
    UCKeyStateRecordsIndex *stateRecordsIndex;
    
    if (uchrTable[i].keyStateRecordsIndexOffset != 0 ) {
      stateRecordsIndex = (UCKeyStateRecordsIndex *) (((unsigned char*)uchrData) + (uchrTable[i].keyStateRecordsIndexOffset));
      
      if ((stateRecordsIndex->keyStateRecordsIndexFormat) != kUCKeyStateRecordsIndexFormat) {
        stateRecordsIndex = NULL;
      }
    }
    else {
      stateRecordsIndex = NULL;
    }
    
    uchrKeyIX = (UCKeyToCharTableIndex *)(((unsigned char *)uchrData) + (uchrTable[i].keyToCharTableIndexOffset));
    
    if (kUCKeyToCharTableIndexFormat == (uchrKeyIX-> keyToCharTableIndexFormat)) {
      for (j = 0; j < (uchrKeyIX->keyToCharTableCount) && !found; j++) {
        UCKeyOutput *keyToCharData = (UCKeyOutput *) ( ((unsigned char*)uchrData) + (uchrKeyIX->keyToCharTableOffsets[j]) );
        
        for (k = 0; k < (uchrKeyIX->keyToCharTableSize) && !found; k++) {
          if (((keyToCharData[k]) & kUCKeyOutputTestForIndexMask) == kUCKeyOutputStateIndexMask) {
            long theIndex = (kUCKeyOutputGetIndexMask & keyToCharData[k]);
            
            if (stateRecordsIndex != NULL && theIndex <= stateRecordsIndex-> keyStateRecordCount) {
              UCKeyStateRecord *theStateRecord = (UCKeyStateRecord *) (((unsigned char *) uchrData) + (stateRecordsIndex-> keyStateRecordOffsets[theIndex]));
              
              if ((theStateRecord->stateZeroCharData) == theCharacter) {
                virtualKeyCode = k;
                found = YES;
              }
            } else {
              if ((keyToCharData[k]) == theCharacter) {
                virtualKeyCode = k;
                found = YES;
              }
            }
          } else if (((keyToCharData[k]) & kUCKeyOutputTestForIndexMask) == kUCKeyOutputSequenceIndexMask) {
          } else if ( (keyToCharData[k]) == 0xFFFE ||  (keyToCharData[k]) == 0xFFFF ) {
          } else {
            if ((keyToCharData[k]) == theCharacter) {
              virtualKeyCode = k;
              found = YES;
            }
          }
        }
      }
    }
  }
  return (CGKeyCode)virtualKeyCode;
}

- (void)executeWithEntry:(KPKEntry *)entry {
  NSAssert(NO, @"Not Implemented");
}

@end
