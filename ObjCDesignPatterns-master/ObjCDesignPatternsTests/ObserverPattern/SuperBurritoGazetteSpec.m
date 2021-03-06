#import "Kiwi.h"
#import "SuperBurritoGazette.h"
#import "NewsReporter.h"
#import "Observer.h"
#import "Swizzlean.h"

@interface SuperBurritoGazette ()

@property (strong, nonatomic) id<NewsReporter> newsReporter;
@property (strong, nonatomic) NSString *newsHeader;

- (void)updateCurrentNewsSnippet;

@end


SPEC_BEGIN(SuperBurritoGazetteSpec)

describe(@"SuperBurritoGazette", ^{
    __block SuperBurritoGazette *superBurritoGazette;
    
    beforeEach(^{
        superBurritoGazette = [[SuperBurritoGazette alloc] init];
    });
    
    it(@"conforms to <Observer>", ^{
        [[superBurritoGazette should] conformToProtocol:@protocol(Observer)];
    });
    
    context(@"#initWithNewsReporter", ^{
        it(@"registers itself as an observer of the NewsReporter passed in", ^{
            id fakeNewsReporter = [KWMock nullMockForProtocol:@protocol(Observer)];
            [[fakeNewsReporter should] receive:@selector(registerObserver:)];
            
            SuperBurritoGazette *supers = [[SuperBurritoGazette alloc] initWithNewsReporter:fakeNewsReporter];
            [[(NSObject *)supers.newsReporter should] equal:fakeNewsReporter];
        });
    });
    
    context(@"#update:", ^{
        it(@"sets the news header", ^{
            [superBurritoGazette update:@"Everybody loves a super burrito!!!"];
            [[superBurritoGazette.newsHeader should] equal:@"Everybody loves a super burrito!!!"];
        });
        
        it(@"updates snippet", ^{
            [[superBurritoGazette should] receive:@selector(updateCurrentNewsSnippet)];
            [superBurritoGazette update:@"This doesn't matter"];
        });
    });
    
    context(@"#updateCurrentNewsSnippet", ^{
        beforeEach(^{
            superBurritoGazette.newsHeader = @"Super!!!";
            [superBurritoGazette updateCurrentNewsSnippet];
        });
        
        it(@"returns news snippet", ^{
            NSString *newsSnippet = [NSString stringWithFormat:@"%@\n->>>Super Burrito Gazette 2013<<<-\n", superBurritoGazette.newsHeader];
            [[superBurritoGazette.snippet should] equal:newsSnippet];
        });
    });
});

SPEC_END

