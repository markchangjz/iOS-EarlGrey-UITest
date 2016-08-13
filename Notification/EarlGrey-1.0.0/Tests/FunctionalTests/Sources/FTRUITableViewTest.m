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

#import "FTRBaseIntegrationTest.h"
#import "FTRTableViewController.h"

@interface FTRUITableViewTest : FTRBaseIntegrationTest
@end

@implementation FTRUITableViewTest

- (void)setUp {
  [super setUp];
  [self openTestViewNamed:@"Table Views"];
}

- (void)tearDown {
  [FTRTableViewController throwErrorIfElementProviderDequeuesCellAtIndex:-1];
  [super tearDown];
}

- (void)testRemoveRow {
  id<GREYMatcher> deleteRowMatcher = grey_allOf(grey_accessibilityLabel(@"Delete"),
                                            grey_kindOfClass([UIButton class]), nil);
  for (int i = 0; i < 5; i++) {
    NSString *labelForRowToDelete = [NSString stringWithFormat:@"Row %d", i];
    [[EarlGrey selectElementWithMatcher:grey_accessibilityLabel(labelForRowToDelete)]
        performAction:grey_swipeFastInDirection(kGREYDirectionLeft)];
    [[EarlGrey selectElementWithMatcher:deleteRowMatcher] performAction:grey_tap()];
    [[EarlGrey selectElementWithMatcher:grey_accessibilityLabel(labelForRowToDelete)]
        assertWithMatcher:grey_notVisible()];
  }
}

- (void)testSearchActionWithTinyScrollIncrements {
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:20 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
  [[self scrollToCellAtIndex:0 byScrollingInAmounts:20 InDirection:kGREYDirectionUp]
      assertWithMatcher:grey_notNil()];
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:20 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
}

- (void)testSearchActionWithLargeScrollIncrements {
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:200 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
  [[self scrollToCellAtIndex:0 byScrollingInAmounts:200 InDirection:kGREYDirectionUp]
      assertWithMatcher:grey_notNil()];
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:200 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
}

- (void)testScrollToTop {
  // Scroll down.
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:200 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
  // Scroll to top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
  // And verify that we are at the top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      assertWithMatcher:[self matcherForScrolledToTop]];
}

- (void)testScrollToTopWithPositiveInsets {
  // Add positive insets using this format {top,left,bottom,right}
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"insets value")]
      performAction:grey_typeText(@"{100,0,0,0}\n")];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"insets toggle")]
      performAction:grey_turnSwitchOn(YES)];
  // Scroll down.
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:200 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
  // Scroll to top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
  // And verify that we are at the top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      assertWithMatcher:[self matcherForScrolledToTop]];
}

- (void)testScrollToTopWithNegativeInsets {
  // Add negative insets using this format {top,left,bottom,right}
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"insets value")]
      performAction:grey_typeText(@"{-100,0,0,0}\n")];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"insets toggle")]
      performAction:grey_turnSwitchOn(YES)];
  // Scroll down.
  [[self scrollToCellAtIndex:20 byScrollingInAmounts:200 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];
  // Scroll to top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
  // And verify that we are at the top.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      assertWithMatcher:[self matcherForScrolledToTop]];
}

- (void)testScrollToTopWhenAlreadyAtTheTopWithoutBounce {
  GREYActionBlock *bounceOff =
      [[GREYActionBlock alloc] initWithName:@"toggleBounces"
                                constraints:grey_kindOfClass([UIScrollView class])
                               performBlock:^BOOL(UIScrollView *scrollView,
                                                  NSError *__strong *error) {
    XCTAssertTrue(scrollView.bounces, @"Bounce must be set or this test is same as"
                                      @" testScrollToTopWhenAlreadyAtTheTopWithBounce");
    scrollView.bounces = NO;
    return YES;
  }];

  // Verify this test with and without bounce enabled by toggling it.
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:bounceOff];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
  // Verify that top most cell is visible.
  [[EarlGrey selectElementWithMatcher:[self matcherForCellAtIndex:0]]
      assertWithMatcher:grey_sufficientlyVisible()];
}

- (void)testScrollToTopWhenAlreadyAtTheTopWithBounce {
  [[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_scrollToContentEdge(kGREYContentEdgeTop)];
  // Verify that top most cell is visible.
  [[EarlGrey selectElementWithMatcher:[self matcherForCellAtIndex:0]]
      assertWithMatcher:grey_sufficientlyVisible()];
}

- (void)testTableViewVisibleWhenScrolled {
  [[[[[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      assertWithMatcher:grey_sufficientlyVisible()]
      performAction:grey_swipeFastInDirection(kGREYDirectionUp)]
      performAction:grey_swipeFastInDirection(kGREYDirectionUp)]
      assertWithMatcher:grey_sufficientlyVisible()];
}

- (void)testFrameworkSynchronizesWithScrolling {
  MatchesBlock matchesNotScrolling = ^BOOL(UIScrollView *element) {
    return !element.dragging && !element.decelerating;
  };
  DescribeToBlock describe = ^void(id<GREYDescription> description) {
    [description appendText:@"scrollViewNotScrolling"];
  };

  id<GREYMatcher> matchers =
      grey_allOf(grey_kindOfClass([UIScrollView class]),
                 [[GREYElementMatcherBlock alloc] initWithMatchesBlock:matchesNotScrolling
                                                      descriptionBlock:describe],
                 nil);
  [[[EarlGrey selectElementWithMatcher:grey_accessibilityID(@"main_table_view")]
      performAction:grey_swipeFastInDirection(kGREYDirectionDown)]
      assertWithMatcher:matchers];
  [[EarlGrey selectElementWithMatcher:grey_accessibilityLabel(@"Row 1")]
      assertWithMatcher:grey_sufficientlyVisible()];
}

- (void)testHiddenElementNotProvided {
  // Scroll down to ensure that the first element is hidden.
  [[self scrollToCellAtIndex:40 byScrollingInAmounts:40 InDirection:kGREYDirectionDown]
      assertWithMatcher:grey_notNil()];

  [FTRTableViewController throwErrorIfElementProviderDequeuesCellAtIndex:1];

  // Try to access the first element and ensure that the element provider does not provide it,
  // since it is hidden.
  NSError *err;
  [[EarlGrey selectElementWithMatcher:grey_accessibilityLabel(@"Row 1")]
      assertWithMatcher:grey_interactable() error:&err];
  GREYAssertNotNil(err, @"Looking for hidden tableview cell failed to produce an error.");
  GREYAssertEqual(err.code, kGREYInteractionElementNotFoundErrorCode,
                  @"Looking for hidden tableview cell produced error with incorrect code.");
}

#pragma mark - Private

- (id<GREYMatcher>)matcherForCellAtIndex:(NSInteger)index {
  return grey_accessibilityLabel([NSString stringWithFormat:@"Row %d", (int)index]);
}

- (GREYElementInteraction *)scrollToCellAtIndex:(NSInteger)index
                         byScrollingInAmounts:(CGFloat)amount
                                  InDirection:(GREYDirection)direction {
  id<GREYMatcher> matcher =
      grey_allOf([self matcherForCellAtIndex:index], grey_interactable(), nil);
  return [[EarlGrey selectElementWithMatcher:matcher]
                usingSearchAction:grey_scrollInDirection(direction, amount)
             onElementWithMatcher:grey_kindOfClass([UITableView class])];
}

- (GREYElementMatcherBlock *)matcherForScrolledToTop {
  BOOL (^isScrolledToTop)(id) = ^BOOL(id element) {
    CGPoint contentOffset = [(UIScrollView *)element contentOffset];
    UIEdgeInsets contentInset = [(UIScrollView *)element contentInset];
    return contentOffset.x + contentInset.left == 0 && contentOffset.y + contentInset.top == 0;
  };
  return [GREYElementMatcherBlock matcherWithMatchesBlock:isScrolledToTop
                                         descriptionBlock:^(id<GREYDescription> description) {
    [description appendText:@"matcherForScrolledToTop"];
  }];
}

@end
