//
//  RootViewController.m
//  MultipleDelete
//
//  Created by huanghy on 16/2/24.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "RootViewController.h"
#import "RootCell.h"
@interface RootViewController ()
{
    //一般创建一个全局的tableview  因为下面有好多方法需要来调用这个tableview
    
    UITableView *_tableView;
    
    //创建一个可变数组 来充当tableview的数据源 之所以选择数组 是因为 数组的元素下标 和  tableview的cell下标是一一对应的
    
    NSMutableArray *_dataArray;
    
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"tableView";
    
    //先创建数据源
    [self creatDataSource];
    
    //再创建tableview
    [self creatTableView];
    
    
    [self creatNavigationBarItem];

}

-(void)creatDataSource{
    
    //先实例化数据源
    
    _dataArray = [[NSMutableArray alloc]init];
    
    for (int z = 0; z<20; z++) {
        
        NSString *string = [NSString stringWithFormat:@"第%d行",z];
        
        [_dataArray addObject:string];
    }
    
    
}

-(void)creatTableView{
    //第二个参数
    
    // UITableViewStylePlain  基本类型 只有一组
    
    //UITableViewStyleGroup   分组类型 先确定有几组 再确定每组有几个cell
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //只要创建tableview  代理方法和数据源方法 就要及时写出来 是必须的
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    //分割线的样式
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}

//创建导航栏两侧的按钮
-(void)creatNavigationBarItem{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(10, 10, 30, 20);
    
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(editTableView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button1.frame = CGRectMake(10, 10, 40, 20);
    
    [button1 setTitle:@"删除" forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(deleteAllData) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)deleteAllData{
    
    //系统会自动的把我们选择的行 或者 反选的行 加入到一个数组里面或者从数组里移除
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[_tableView indexPathsForSelectedRows]];
    
    //给这个数组按照倒序排序
    [array sortedArrayUsingSelector:@selector(compare:)];
    
    //遍历这个数组
    
    for (NSInteger b = array.count - 1; b>=0; b--) {
        
        //根据b在数组里面的位置 定位到到底是哪一行
        
        NSIndexPath *indexPath = array[b];
        
        [_dataArray removeObjectAtIndex:indexPath.row];
    }
    
    
    [_tableView reloadData];
}
-(void)editTableView{
    
    _tableView.editing = !_tableView.editing;
    
}

//应该让这个tableview 每组显示多少行数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

//关于tableviewcell的复用机制 返回参数就是 UITableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    //我创建一个静态标识符 来给每一个cell加上标记 方便我们从复用队列里面取到 名字为该标记的cell
//    
//    //    static NSString *reuseID = @"ID";
//    
//    static NSInteger num = 0;
//    //我创建一个cell  先从复用队列 dequeue  里面用上面创建的静态标识符来取
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
//    
//    //做一个if判断 如果队列里面没有这个cell  那我们就创建一个新的 并且 还要给这个cell 加上复用标识符
//    
//    if (!cell) {
//        
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
//        
//        
//        num ++;
//        
//        NSLog(@"%d",num);
//    }
//    
//    
//    //给tableviewcell上面加载数据
//    
//    //    indexPath.section  indexPath.row的理解 indexPath是定位用的 到底定位到 哪一组还是哪一行 根据情况来看
//    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
//    
//    cell.detailTextLabel.text = [_dataArray objectAtIndex:indexPath.row];
//    return cell;
    RootCell *rootCell = [tableView dequeueReusableCellWithIdentifier:@"RootCell"];
    if (rootCell == nil) {
        rootCell = [[[NSBundle mainBundle] loadNibNamed:@"RootCell" owner:self options:nil] firstObject];
    }
   // rootCell.selectionStyle = UITableViewCellSelectionStyleNone;//这个设置使点击cell的时候没有点击效果了

    return rootCell;
}

//设置每个cell的高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

//点击某个cell的方法 点击这一行想做什么事儿的代码 都写在这个方法里
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"您点击了第%d行",indexPath.row);
    
    //让cell点击的背景色 变回来
    
    
    if (tableView.editing == YES) {
        
        
    }
}

#pragma mark  **删除 增加 **
//第一步 是否允许tableview的某一行进行编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
//第二步 返回tableviewcell的编辑类型 （到底是让这个cell删除啊 还是增加啊）

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    if (indexPath.row%2 == 0) {
    //
    //        return UITableViewCellEditingStyleDelete;
    //
    //    }else{
    //
    //        return UITableViewCellEditingStyleInsert;
    //
    //    }
    
    
    //开启多选删除的模式
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//第三步 开始对这个cell进行编辑

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //先判断当前的cell的编辑类型是删除还是增加
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //先操作数据源
        [_dataArray removeObjectAtIndex:indexPath.row];
        
        //再操作UI
        //   [tableView deleteRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationLeft];
        
    }
    [tableView reloadData];
}

//返回删除按钮的title
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
