//
// Copyright 2016 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <EarlGrey/GREYConstants.h>
#import <EarlGrey/GREYDefines.h>
#import <Foundation/Foundation.h>

@protocol GREYAction;

/**
 *  A interface that exposes UI element actions.
 */
@interface GREYActions : NSObject

/**
 *  @return A GREYAction that performs double tap on an element.
 */
+ (id<GREYAction>)actionForDoubleTap;

/**
 *  Returns an action that holds down finger for 1.0 second (@c kGREYLongPressDefaultDuration) to
 *  simulate a long press.
 *
 *  @return A GREYAction that performs a long press on an element.
 */
+ (id<GREYAction>)actionForLongPress;

/**
 *  Returns an action that holds down finger for specified @c duration to simulate a long press.
 *
 *  @param duration The duration of the long press.
 *
 *  @return A GREYAction that performs a long press on an element.
 */
+ (id<GREYAction>)actionForLongPressWithDuration:(CFTimeInterval)duration;

/**
 *  Returns an action that holds down finger for specified @c duration at the specified @c point
 *  (interpreted as being relative to the element) to simulate a long press.
 *
 *  @param point    The point that should be tapped.
 *  @param duration The duration of the long press.
 *
 *  @return A GREYAction that performs a long press on an element.
 */
+ (id<GREYAction>)actionForLongPressAtPoint:(CGPoint)point duration:(CFTimeInterval)duration;

/**
 *  Returns an action that scrolls a @c UIScrollView by @c amount (in points) in the specified
 *  @c direction.
 *
 *  @param direction The direction of the swipe.
 *  @param amount    The amount of points in CGPoints to scroll.
 *
 *  @return A GREYAction that scrolls a scroll view in a given @c direction for a given @c amount.
 */
+ (id<GREYAction>)actionForScrollInDirection:(GREYDirection)direction amount:(CGFloat)amount;

/**
 *  @return A GREYAction that scrolls to the given content @c edge of a scroll view.
 */
+ (id<GREYAction>)actionForScrollToContentEdge:(GREYContentEdge)edge;

/**
 *  Returns an action that fast swipes through the whole view. The start point of the swipe is
 *  chosen to achieve the maximum the swipe possible to the other edge.
 *
 *  @param direction The direction of the swipe.
 *
 *  @return A GREYAction that performs a fast swipe in the given direction.
 */
+ (id<GREYAction>)actionForSwipeFastInDirection:(GREYDirection)direction;

/**
 *  Returns an action that slow swipes through the whole view. The start point of the swipe is
 *  chosen to achieve maximum the swipe possible to the other edge.
 *
 *  @param direction The direction of the swipe.
 *
 *  @return A GREYAction that performs a slow swipe in the given direction.
 */
+ (id<GREYAction>)actionForSwipeSlowInDirection:(GREYDirection)direction;

/**
 *  Returns an action that swipes through the view quickly in the given @c direction from a specific
 *  origin. The duration here is specified by @c kGREYSwipeFastDuration in GREYConstants.
 *
 *  @param direction              The direction of the swipe.
 *  @param xOriginStartPercentage the x start position as a percentage of the total width
 *                                of the view. This must be between 0 and 1.
 *  @param yOriginStartPercentage the y start position as a percentage of the total height
 *                                of the view. This must be between 0 and 1.
 *
 *  @return A GREYAction that performs a fast swipe through a view in a specific direction from
 *          the specified point.
 */
+ (id<GREYAction>)actionForSwipeFastInDirection:(GREYDirection)direction
                         xOriginStartPercentage:(CGFloat)xOriginStartPercentage
                         yOriginStartPercentage:(CGFloat)yOriginStartPercentage;

/**
 *  Returns an action that swipes through the view quickly in the given @c direction from a specific
 *  origin. The duration here is specified by @c kGREYSwipeSlowDuration in GREYConstants.
 *
 *  @param direction              The direction of the swipe.
 *  @param xOriginStartPercentage the x start position as a percentage of the total width
 *                                of the view. This must be between 0 and 1.
 *  @param yOriginStartPercentage the y start position as a percentage of the total height
 *                                of the view. This must be between 0 and 1.
 *
 *  @return A GREYAction that performs a slow swipe through a view in a specific direction from
 *          the specified point.
 */
+ (id<GREYAction>)actionForSwipeSlowInDirection:(GREYDirection)direction
                         xOriginStartPercentage:(CGFloat)xOriginStartPercentage
                         yOriginStartPercentage:(CGFloat)yOriginStartPercentage;

/**
 *  Returns an action that attempts to move slider to within 1.0e-6f values of @c value.
 *
 *  @param value The value to which the slider should be moved. If this is not attainable after a
 *               reasonable number of attempts (currently 10) we assume that the @c value is
 *               unattainable for a user (it is probably the case this value resides between two
 *               pixels). In this case, the slider will end up at a user attainable value
 *               that is closest to @c value.
 *
 *  @return A GREYAction that moves a slider to a given @c value.
 */
+ (id<GREYAction>)actionForMoveSliderToValue:(float)value;

/**
 *  Returns an action that changes the value of UIStepper to @c value by tapping the appropriate
 *  button multiple times.
 *
 *  @param value The value to change the UIStepper to.
 *
 *  @return A GREYAction that sets the given @c value on a stepper.
 */
+ (id<GREYAction>)actionForSetStepperValue:(double)value;

/**
 *  Returns an action that taps on an element at the activation point of the element.
 *
 *  @return A GREYAction to tap on an element.
 */
+ (id<GREYAction>)actionForTap;

/**
 *  Returns an action that taps on an element at the specified @c point.
 *
 *  @param point The point that should be tapped. It must be in the coordinate system of the
 *               element and it's position is relative to the origin of the element, as in
 *               (element_width/2, element_height/2) will tap at the center of element.
 *
 *  @return A GREYAction to tap on an element at a specific point.
 */
+ (id<GREYAction>)actionForTapAtPoint:(CGPoint)point;

/**
 *  Returns an action that uses the iOS keyboard to input a string.
 *
 *  @param text The text to be typed. Backspace is supported by using "\b" in the string.
 *              Return key is supported with "\n".
 *              For Example: @"Helpo\b\bloWorld" will type HelloWorld.
 *
 *  @return A GREYAction to type a specific text string in a text field.
 */
+ (id<GREYAction>)actionForTypeText:(NSString *)text;

/**
 *  @return A GREYAction that clears a text field by injecting back-spaces.
 */
+ (id<GREYAction>)actionForClearText;

/**
 *  Returns an action that toggles a switch control. This action is applicable to all elements that
 *  implement the selector UISwitch::isOn and include UISwitch controls.
 *
 *  @param on The switch control state.
 *
 *  @return A GREYAction to toggle a UISwitch.
 */
+ (id<GREYAction>)actionForTurnSwitchOn:(BOOL)on;

/**
 *  Returns an action that injects dates/times into UIDatePickers.
 *
 *  @param date The date to set the UIDatePicker.
 *
 *  @return A GREYAction that sets a given date/time on a UIDatePicker.
 */
+ (id<GREYAction>)actionForSetDate:(NSDate *)date;

/**
 *  Returns an action that selects @c value on the given @c column of a UIPickerView.
 *
 *  @param column The UIPickerView column being set.
 *  @param value  The value to set the UIPickerView.
 *
 *  @return A GREYAction to set the value of a specified column of a UIPickerView.
 */
+ (id<GREYAction>)actionForSetPickerColumn:(NSInteger)column toValue:(NSString *)value;

/**
 *  Returns an action that executes JavaScript against a UIWebView and sets the return value to
 *  @c outResult if provided.
 *
 *  @param js     The Javascript code to be executed.
 *  @param output The result of the code execution.
 *
 *  @return A GREYAction that executes JavaScript code against a UIWebView.
 */
+ (id<GREYAction>)actionForJavaScriptExecution:(NSString *)js
                                        output:(out __strong NSString **)outResult;

/**
 *  Returns an action that takes a snapshot of the selected element.
 *
 *  @param outImage The UIImage where the image content is stored.
 *
 *  @return A GREYAction that takes a snapshot of an UI element.
 */
+ (id<GREYAction>)actionForSnapshot:(out __strong UIImage **)outImage;

#if !(GREY_DISABLE_SHORTHAND)
/** Shorthand macro for GREYActions::doubleTap. */
GREY_EXPORT id<GREYAction> grey_doubleTap(void);

/** Shorthand macro for GREYActions::longPress. */
GREY_EXPORT id<GREYAction> grey_longPress(void);

/** Shorthand macro for GREYActions::longPressWithDuration:. */
GREY_EXPORT id<GREYAction> grey_longPressWithDuration(CFTimeInterval duration);

/** Shorthand macro for GREYActions::longPressAtPoint:duration:. */
GREY_EXPORT id<GREYAction> grey_longPressAtPointWithDuration(CGPoint point,
                                                             CFTimeInterval duration);

/** Shorthand macro for GREYActions::scrollInDirection:amount:. */
GREY_EXPORT id<GREYAction> grey_scrollInDirection(GREYDirection direction, CGFloat amount);

/** Shorthand macro for GREYActions::scrollToContentEdge:. */
GREY_EXPORT id<GREYAction> grey_scrollToContentEdge(GREYContentEdge edge);

/** Shorthand macro for GREYActions::swipeFastInDirection:. */
GREY_EXPORT id<GREYAction> grey_swipeFastInDirection(GREYDirection direction);

/** Shorthand macro for GREYActions::swipeSlowInDirection:. */
GREY_EXPORT id<GREYAction> grey_swipeSlowInDirection(GREYDirection direction);

/**
 *  Shorthand macro for
 *  GREYActions::swipeFastInDirection:xOriginStartPercentage:yOriginStartPercentage:.
 */
GREY_EXPORT id<GREYAction> grey_swipeFastInDirectionWithStartPoint(GREYDirection direction,
                                                                   CGFloat xStartPoint,
                                                                   CGFloat yStartPoint);

/**
 *  Shorthand macro for
 *  GREYActions::swipeSlowInDirection:xOriginStartPercentage:yOriginStartPercentage:.
 */
GREY_EXPORT id<GREYAction> grey_swipeSlowInDirectionWithStartPoint(GREYDirection direction,
                                                                   CGFloat xStartPoint,
                                                                   CGFloat yStartPoint);

/** Shorthand macro for GREYActions::moveSliderToValue:. */
GREY_EXPORT id<GREYAction> grey_moveSliderToValue(float value);

/** Shorthand macro for GREYActions::setStepperValue:. */
GREY_EXPORT id<GREYAction> grey_setStepperValue(double value);

/** Shorthand macro for GREYActions::tap. */
GREY_EXPORT id<GREYAction> grey_tap(void);

/** Shorthand macro for GREYActions::tapAtPoint:. */
GREY_EXPORT id<GREYAction> grey_tapAtPoint(CGPoint point);

/** Shorthand macro for GREYActions::type:. */
GREY_EXPORT id<GREYAction> grey_typeText(NSString *text);

/** Shorthand macro for GREYActions::clearText. */
GREY_EXPORT id<GREYAction> grey_clearText(void);

/** Shorthand macro for GREYActions::turnSwitchOn:. */
GREY_EXPORT id<GREYAction> grey_turnSwitchOn(BOOL on);

/** Shorthand macro for GREYActions::setDate:. */
GREY_EXPORT id<GREYAction> grey_setDate(NSDate *date);

/** Shorthand macro for GREYActions::setPickerColumn:toValue:. */
GREY_EXPORT id<GREYAction> grey_setPickerColumnToValue(NSInteger column, NSString *value);

/** Shorthand macro for GREYActions::javaScriptExecution:output:. */
GREY_EXPORT id<GREYAction> grey_javaScriptExecution(NSString *js, __strong NSString **outResult);

/** Shorthand macro for GREYActions::snapshot:. */
GREY_EXPORT id<GREYAction> grey_snapshot(__strong UIImage **outImage);

#endif // GREY_DISABLE_SHORTHAND

@end
