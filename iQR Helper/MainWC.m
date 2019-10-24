#import "MainWC.h"
#import "DynamicCodesController.h"
#import "DynamicCode.h"

@interface MainWC ()

@property IBOutlet DynamicCodesController *dynamicCodesController;
@property IBOutlet NSTableView *tableView;

@end

@implementation MainWC

- (NSNibName)windowNibName
{
    return @"Main";
}

- (void)setWorkingPath:(NSString *)workingPath
{
    if (_workingPath != workingPath) {
        _workingPath = workingPath;
        [self loadCodesWithPath:workingPath];
    }
}

- (void)loadCodesWithPath:(NSString *)path
{
    [[self dynamicCodesController] loadCodesWithPath:path];
}

- (void)saveCodesToPath:(NSString *)path
{
    [[self dynamicCodesController] saveCodesToPath:path];
}

- (IBAction)saveBack:(id)sender
{
    [self saveCodesToPath:[self workingPath]];
}

- (IBAction)exportAll:(id)sender
{
    NSSavePanel *savePanel = [self savePanel];
    [savePanel beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            if ([savePanel URL]) {
                NSString *content = [self.dynamicCodesController stringContent];
                NSError *fileError;
                [content writeToURL:[savePanel URL] atomically:YES encoding:NSUTF8StringEncoding error:&fileError];
                if (fileError) {
                    NSLog(@"%@", fileError);
                    [[NSApplication sharedApplication] presentError:fileError];
                }
            }
        }
    }];
}

- (NSSavePanel *)savePanel
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setPrompt:@"Export"];
    [savePanel setTitle:@"Export"];
    [savePanel setExtensionHidden:YES];
    [savePanel setAllowsOtherFileTypes:NO];
    [savePanel setAllowedFileTypes:@[@"txt", (NSString *)kUTTypePlainText]];
    return savePanel;
}

- (id <NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row
{
    return [[self dynamicCodesController] arrangedObjects][row];
}

//no need for keyDown+tableView if we add a keyboard shortcut to mainMenu
- (void)delete:(nullable id)sender
{
    [self.dynamicCodesController remove:nil];
}

- (void)copy:(nullable id)sender
{
    NSArray<DynamicCode*>*codes = [self.dynamicCodesController selectedObjects];
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeObjects:codes];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
    if ([menuItem action] == @selector(copy:) || [menuItem action] == @selector(delete:) ) {
        return [[self.dynamicCodesController selectedObjects] count] ? YES : NO;
    }
    if ([menuItem action] == @selector(exportAll:) ) {
        return [[self.dynamicCodesController arrangedObjects] count] ? YES : NO;
    }
    
    return YES;
}

@end
