# LPSideMenu
侧滑视图控制器;抽屉视图控制器

### 效果图 
<img src='https://github.com/iOSSer/LPSideMenu/blob/master/LPSideMenuDemo/LPSideMenuDemo/iOS%20Simulator%20Screen%20Shot%202015%E5%B9%B48%E6%9C%8828%E6%97%A5%20%E4%B8%8B%E5%8D%884.05.50.png' width = 320 height = 568></img>

### 使用方法
Appdelegate中初始化

    #import "LPSideMenu.h"
    #import "LeftViewController.h"
    #import "CenterViewController.h"
    @property (nonatomic, strong) LPSideMenu *menu;
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CenterViewController *content = [[CenterViewController alloc] init];
    UINavigationController *contentNav = [[UINavigationController alloc] initWithRootViewController:content];
    LeftViewController *left = [[LeftViewController alloc] init];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:left];
    self.menu = [[LPSideMenu alloc] initWithContentViewController:contentNav leftViewController:leftNav];
    self.window.rootViewController = self.menu;
    [self.window makeKeyAndVisible];
    
    return YES;
   }
#### 内容视图显示位置
    //    self.menu.scrollOffset = 0.5;//可不设置默认为0.4，即中间视图内容只显示出:屏幕宽度 * 0.4;
#### 显示与隐藏
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.menu showLeft:!delegate.menu.isShowing];//YES or NO
#### 是否可用
    delegate.menu.menuEnable = YES;

<!--![ScreenShot][ScreenShot]-->

<!--[ScreenShot]:https://github.com/iOSSer/LPSideMenu/blob/master/LPSideMenuDemo/LPSideMenuDemo/iOS%20Simulator%20Screen%20Shot%202015%E5%B9%B48%E6%9C%8828%E6%97%A5%20%E4%B8%8B%E5%8D%884.05.50.png "ScreenShot"-->
