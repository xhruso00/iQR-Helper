#import "NSTableView+Additions.h"

@implementation NSTableView(Additions)

- (NSIndexSet *)indexesToProcessForContextMenu
{
    NSIndexSet *selectedIndexes = self.selectedRowIndexes;
    // If the clicked row was in the selectedIndexes, then we process all selectedIndexes.
    // Otherwise, we process just the clickedRow.
    //
    if (self.clickedRow != -1 && ![selectedIndexes containsIndex:self.clickedRow]) {
        selectedIndexes = [NSIndexSet indexSetWithIndex:self.clickedRow];
    }
    return selectedIndexes;
}

@end
