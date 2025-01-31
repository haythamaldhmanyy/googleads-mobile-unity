// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GADUNativeTemplateTextStyle.h"
#import "GADUPluginUtil.h"

@implementation GADUNativeTemplateTextStyle

- (nonnull instancetype)initWithTextColor:(nullable UIColor *)textColor
                          backgroundColor:(nullable UIColor *)backgroundColor
                                fontStyle:(GADUNativeTemplateFontStyle)fontStyle
                                     size:(nullable NSNumber *)size {
  self = [super init];
  if (self) {
    _textColor = textColor;
    _backgroundColor = backgroundColor;
    _fontStyle = fontStyle;
    _size = size;
  }
  return self;
}

- (nullable UIFont *)font {
  if ([GADUPluginUtil isNull:_size]) {
    return nil;
  }

  CGFloat size = [GADUPluginUtil isNull:_size] ? UIFont.systemFontSize : _size.floatValue;
  switch (_fontStyle) {
    case GADUNativeTemplateFontNormal:
      return [UIFont systemFontOfSize:size];
    case GADUNativeTemplateFontBold:
      return [UIFont boldSystemFontOfSize:size];
    case GADUNativeTemplateFontItalic:
      return [UIFont italicSystemFontOfSize:size];
    case GADUNativeTemplateFontMonospace:
      if (@available(iOS 13.0, *)) {
        return [UIFont monospacedSystemFontOfSize:size weight:UIFontWeightRegular];
      } else {
        return [UIFont monospacedDigitSystemFontOfSize:size weight:UIFontWeightRegular];
      }
    default:
      NSLog(@"Unknown fontStyle case: %ld", _fontStyle);
      return [UIFont systemFontOfSize:size];
  }
}

@end
