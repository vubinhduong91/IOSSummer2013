//
//  danhSachDongVat.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "danhSachDongVat.h"
#import "dongVat.h"

@interface danhSachDongVat ()
@property (strong, nonatomic) NSMutableArray * theList;
@property (nonatomic) int typeNum;
@end


@implementation danhSachDongVat



- (void)InitTheList {
	if (!_theList) {
        _theList = [[NSMutableArray alloc] init];
        if(self.type == 1) //dat
        {
            
            
            [_theList addObject:[[dongVat alloc] initWithName:@"Bò Sữa" :@"question13.png" :@"Bò sữa là họ bò nhà (giống cái) được nuôi với khả năng cung cấp sữa dồi dào. Nguồn sữa bò này được dùng biến chế thành nhiều sản phẩm khác. Bò sữa có thân đốm trắng đốm đen và thích ăn cỏ."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Chó" :@"question18.png" :@"Chó là loài vật gần gũi nhất với con nguời. Chó thích gặm xuơng. Chó là loài vật rất trung thành với chủ. Mắt chó có đến 3 mí: một mí trên, một mí dưới và mí thứ ba nằm ở giữa, hơi sâu vào phía trong, giúp bảo vệ mắt khỏi bụi bẩn. Tai của chúng rất thính, chúng có thể nhận được 35.000 âm rung chỉ trong một giây. Khứu giác của chúng cũng rất thính như tai. Người ta có thể ngửi thấy mùi thức ăn ở đâu đó trong nhà bếp nhưng chó thì có thể phân biệt từng gia vị trong nồi, thậm chí những chú chó săn còn tìm ra những cây nấm con nằm sâu trong rừng, vì chúng có thể phân biệt gần 220 triệu mùi. Não chó rất phát triển. Chó phân biệt vật thể đầu tiên là dựa vào chuyển động sau đó đến ánh sáng và cuối cùng là hình dạng. "]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Khủng long" :@"question19.png" :@"Khủng long là nhóm đa dạng nhất của động vật có xương sống bên cạnh cá vược. Các nhà cổ sinh vật học đã xác định hơn 500 chi khác biệt và hơn 1.000 loài khác nhau không phải chim. Khủng long sống trên mọi lục địa bởi vẫn còn hóa thạch ở đó chứng minh. Một số loài khủng long ăn cỏ, những loài khác ăn thịt. Nhiều loài khủng long, trong đó có chim, có thể đi bằng hai chân, mặc dù nhiều nhóm đã tuyệt chủng đi bằng bốn chân, và một số đã có thể chuyển đổi giữa các tư thế cơ thể. Nhiều loài có cấu trúc như sừng hoặc mào, và một số nhóm cổ đại phát triển và thay đổi xương như vậy thậm chí còn phức tạp hơn như áo giáp xương.Loài chim đã được chi phối của bầu trời hành tinh và trở thành động vật có xương sống bay phát triển nhất kể từ sự tuyệt chủng của thằn lằn bay. Mặc dù thường được biết đến với kích thước lớn của một số loài, hầu hết các loài khủng long có kích thước người bình thường hoặc thậm chí nhỏ hơn. Tất cả các loài khủng long đều xây tổ và đẻ trứng."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Mèo" :@"question14.png" :@"Mèo là loài vật nuôi trong nhà. Mèo có lông màu đen, trắng, hay đốm. Mèo rất thích ăn cá và luôn keo meo meo. Mèo là những vận động viên điền kinh. Những kẻ chạy nước rút tài giỏi, chúng có thể đạt tới tốc độ 30 dặm một giờ trên những khoảng cách ngắn. Mèo có thể nhảy cao tới đỉnh rào hay một bức tường cao 3 mét từ tư thế đứng yên. Mèo nhà là một trong số ít loài vật bốn chân không có các xương đòn cứng. Điều này cho phép mèo chui qua lỗ hổng có kích thước bằng đầu chúng."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Nhim" :@"question15.png" :@"Nhím đực có mỏ dài, đầu nhọn, thân hình thon dài, đuôi dài hơn con cái. Nhím cái mỏ ngắn, đầu hơi tròn, thân hình quả trám, đuôi ngắn và mập hơn con đực. Nhím ăn các loại rễ cây, mầm cây, rau, củ, quả ngọt bùi đắng chát...Ít khi uốngnước, vì nhím ăn nhiều rau, quả... và đặt biệt là các loại cây có bài thuốc trị về những vấn đề rối loạn đường ruột, vì vậy bao tử nhím được xem là một trong những bộ phận khá đặc biệt đối với loài nhím."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Thỏ" :@"question12.png" :@"Thỏ có bộ lông màu trắng, có đôi tai rất thính và rất thích ăn quả cả rốt. Thỏ rất nhát và chạy rất nhanh nên đuợc gọi là Nhanh Như Thỏ. Một con thỏ nhà có thể sống tới 10 năm hoặc hơn nữa. Chúng thích ném đồ chơi lung tung và gặm nhấm trên bìa cứng. Trong một số gia đình, thỏ có thể nảy sinh sự đồng cảm với mèo và chó. Dù bị nhốt trong những cái chuồng nhỏ hẹp nhưng thỏ cũng được huấn luyện để trở thành vật nuôi tự do như chó và mèo. Nếu được nuôi trong môi trường thích hợp và ăn kiêng đúng mức, thỏ sẽ sống lâu hơn."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Trâu" :@"question10.png" :@"Trâu là động vật rất khoẻ. Trâu có bộ da đen và có hai cái sừng nhọn. Trâu là bạn của nhà nông. Con trâu là hình ảnh của bản chất hiền lành, cần cù của con người Việt, là nét đẹp tinh hoa văn hóa từ bao đời nay."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Voi" :@"question16.png" :@"Hằng ngày, voi dành khoảng 16 tiếng đồng hồ để tìm kiếm thức ăn và chỉ ngủ khoảng từ 3 đến 5 tiếng. Voi trưởng thành ngủ đứng. Voi con đôi khi ngủ nằm. Voi tuy to lớn, nhưng điều đó không ngăn cản chúng trở thành những tay bơi giỏi. Chúng rất thích bơi và thậm chí có thể bơi ở biển. Thời gian ưa thích trong ngày của chúng là khi tắm bùn. Bùn bảo vệ voi khỏi bị ánh nắng thiêu đốt và giữ cho voi được mất mẻ, tránh được những con bọ khó chịu. Voi dùng vòi để quặp thức ăn và đưa vào miệng. Thức ăn chủ yếu của chúng là cỏ và các loại cây khác trên mặt đất. Voi dùng vòi để kéo lá cây, thân cây và cành cây từ trên cao xuống. Khi thức ăn khan hiếm, voi dùng ngà để húc đổ cây."]];
            
        }
        else if(self.type == 2) //nuoc
        {
            [_theList addObject:[[dongVat alloc] initWithName:@"Bạch tuộc" :@"question24.png" :@"Bạch tuộc có 8 cánh tay (không phải xúc tu). Bạch tuộc có vòng đời tương đối ngắn, có loài chỉ sống được 6 tháng. Bạch tuộc có đến 3 trái tim. Bạch tuộc là động vật rất thông minh, có thể là thông minh hơn bất kỳ một động vật thân mềm nào. Hầu hết loài bạch tuộc có thể phun ra một loại mực hơi đen và dày như một đám mây lớn để thoát khỏi kẻ thù. Bạch tuộc di chuyển bằng cách bò hoặc bơi. Nhưng cách di chuyển chính của chúng là bò, thỉnh thoảng mới bơi. Chúng chỉ di chuyển nhanh khi đói hoặc bị đe dọa, khi đó bạch tuộc lợi dụng sức đẩy của phản lực. Lượng ôxy trong máu bạch tuộc chỉ khoảng 4% nên sức chịu đựng của chúng khá kém."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Cá đuối" :@"question28.png" :@"Cá đuối là cá có cơ thể bẹt. Các mắt và các lỗ thở nằm trên đỉnh đầu. Cá đuối sống tại đáy biển. Phần lớn các loài cá đuối có các răng phát triển, nặng, thuôn tròn để nghiền mai hay vỏ cuat các loài sinh vật tầng đáy như ốc, trai, hàu, động vật giáp xác, và một vài loài cá, phụ thuộc vào từng loài. Cá ó nạng hải ăn các thức ăn là động vật phù du."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Cá heo" :@"question27.png" :@"Hầu hết cá heo đều có nhãn lực tinh tường cả trong môi và ngoài môi trường nước và có thể cảm nhận các tần số cao gấp 10 lần tần số người có thể nghe được. Mặc dù cá heo có lỗ tai nhỏ ở hai bên đầu, người ta cho rằng trong môi trường nước, cá nghe bằng hàm dưới và dẫn âm thanh tới tai giữa qua những khe hở chứa mở trong xương hàm. Nghe cũng được dùng để phát sóng rada sinh học, một khả năng tất cả các loài cá heo đều có. Người ta cho rằng răng cá heo được dùng như cơ quan thụ cảm, chúng nhận các âm thanh phát tới và chỉ chính xác vị trí của đối tượng.Xúc giác của cá heo cũng rất phát triển, với đầu dây thần kinh phân bổ dày đặc trên da, nhất là ở mũi, vây ngực và vùng sinh dục. Tuy nhiên cá heo không có các tế bào thần kinh thụ cảm mùi và vì vật chúng được tin là không có khứu giác.Cá heo cũng có vị giác và thể hiện thích một số thức ăn cá nhất định. Hầu hết thời gian của cá heo là dưới mặt nước, cảm nhận vị của nước có thể giúp cá heo ngửi theo cách là vị nước có thể cho cá biết sự hiện diện của các vật thể ngoài miệng mình."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Cá mập" :@"question23.png" :@"Khứu giác hoàn hảo và thị giác khá tốt cộng thêm khả năng cảm nhận điện trường của động vật đã ấn định cho cá mập ngôi vị vua biển cả. Với giác quan này, một con cá mập có thể xác định mùi máu, hay nước tiểu của con mồi ở xa hàng km. Bởi vậy điều này mà nhiều người nghĩ nếu bị chảy máu thì không nên tắm biển hay lướt sóng vì sợ bị tấn công. Nhưng chính do khứu giác rất tốt của cá mập mà nó dễ dàng phân biệt máu người và máu con mồi ngoài tự nhiên, nên nó không thể bị nhầm lẫn và sẽ không tấn công vì cá mập không coi con người là con mồi."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Cá ngựa" :@"question26.png" :@"Cá ngựa sinh con theo một cách kỳ lạ: con đực mang thai. Thông thường cá ngựa sống thành cặp, nhưng có một số loài sống thành bầy đàn. Khi sống thành cặp, cá ngựa thường giao phối vào sáng sớm hoặc đôi khi vào chập tối để củng cố thêm mối quan hệ của chúng. Phần thời gian còn lại chúng dành cho việc tìm thức ăn. Nhiều người nuôi cá ngựa như thú cưng. Cá ngựa chỉ ăn thức ăn tươi như tôm biển và thường nằm úp người xuống bể, hành động này sẽ làm cho hệ thống miễn dịch của chúng hoạt động yếu hơn, từ đó mà dễ mắc các bệnh."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Cua" :@"question21.png" :@"Cua có thân rộng hơn bề dài, mai mềm, mười chân có khớp, hai chân trước tiến hóa trở thành hai càng, vỏ xương bọc ngoài thịt, phần bụng nằm bẹp dưới hoàn toàn được che bởi phần ngực. Động vật dạng cua có nhiều tại tất cả các vùng biển, đại dương. Có loài sống trong sông, suối, đồng ruộng. Tất cả các loài động vật dạng cua đều có 10 chân, 2 càng to ở phía trước dùng để tự vệ và xé thức ăn. Chúng bò ngang với tốc độ khá nhanh."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Sao biển" :@"question25.png" :@"Sao biển nằm trong số quen thuộc nhất của động vật biển và có một số đặc điểm được biết đến rộng rãi, chẳng hạn như tái sinh và thức ăn con trai. Chúng có một loạt kiểu thân và phương pháp ăn đa dạng. Mức độ mà sao biển có thể tái sinh thay đổi với các loài cá thể. Nói chung, những con sao biển là loài kiếm ăn cơ hội, với một số loài có hành vi ăn chuyên ngành, bao gồm cả ăn treo và ăn thịt con mồi cụ thể."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Sứa" :@"question20.png" :@"Sứa bơi và nổi lên trên mặt nước và phần lớn cơ thể có dạng Hình dù được hình thành từ chất liệu như thạch đông có màu trong suốt do có tới 98% là nước. Từ mép chuông, những sợi râu kéo lê trong biển, trung tâm là cái miệng của nó. Sứa hình dù. Miệng nằm ở dưới, đối xứng tỏa tròn. Tầng keo của sứa dày lên làm cơ thể sứa dễ nổi và khiến cho khoang tiêu hóa thu hẹp lại, thông với lỗ miệng quay về phía dưới. Tua dù có nhiều ở mép dù. Cũng như thủy tức, sứa là động vật ăn thịt, bắt mồi bằng tua miệng."]];
            
        }
        else if(self.type == 3) //troi
        {
            [_theList addObject:[[dongVat alloc] initWithName:@"Bồ câu" :@"question5.png" :@"Bồ câu có thể sống trong mọi môi trường khắc nghiệt. Da khô phủ lông vũ. Chim bồ câu là biểu tượng cho sự hòa bình, yên vui và hạnh phúc"]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Bồ nông" :@"question6.png" :@"Các loài bồ nông có chiếc mỏ dài và túi cổ họng lớn đặc trưng, được sử dụng để bắt con mồi và thoát nước từ mồi được nó xúc lên trước khi nuốt. Các loài bồ nông có bộ lông chủ yếu là màu nhạt"]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Chim họa mi" :@"question1.png" :@"Họa mi có hình dáng nhỏ ,thon,nhìn từ phía trước thì tiết diện hình tròn. Họa mi có tiếng hót vang và rất hay."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Chuồn chuồn" :@"question9.png" :@"Chuồn chuồn có đầu tròn và khá lớn so với thân được bao phủ phần lớn bởi hai mắt kép lớn hai bên, các cặp chân có thể bắt mồi dễ dàng trong khi bay. Hai cánh hai bên giống nhau, dài, mỏng và gần như trong suốt, và cử động độc lập nhau. Chuồn chuồn sống gần các đầm hay ao hồ. Trứng chuồn chuồn được đẻ vào mặt nước hoặc trên cành, lá thủy sinh gần ao, hồ, và các khu vực ẩm ướt hoặc trong mô cây ở nước, và nở thành tiền ấu trùng sống bằng các chất dinh dưỡng có trong trứng."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Dơi" :@"question2.png" :@"Dơi là loài thú duy nhất có thể bay được. Khoảng 70% số loài dơi ăn sâu bọ, số còn lại chủ yếu ăn hoa quả và chỉ có vài loài ăn thịt. Dơi cần thiết cho sinh thái bởi chúng đóng vai trò thụ phấn hoa hay phát tán hạt cây, sự phân tán của nhiều loài cây lệ thuộc hoàn toàn vào dơi. Dơi phát siêu âm với tần số 30.000-70.000 Hz. Nhờ tiếp nhận siêu âm vào tai, dơi có thể ước lượng khoảng xa của chướng ngại vật."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Đại bàng" :@"question3.png" :@"Đại bàng là một loài chim săn mồi cỡ lớn. Đại bàng thường làm tổ trên núi hoặc cây cao.Tổ của chúng rất lớn và mỗi năm chúng lại tha về tổ nhiều cành cây mới để làm cho tổ kiên cố hơn trước.Tổ là nơi chim cái đẻ trứng.Mỗi kì sinh nở thì chim cái sinh 2 trứng.Do chim bố mẹ chỉ có khả năng nuôi một chim non nên thường sẽ có cuộc quyết đấu giữa hai chim con.Con nào thắng sẽ được nuôi cho đến khi trưởng thành. Một đặc tính nổi bật của loài chim này là cách chúng đón đầu cơn bão. Khi đại bàng biết cơn bão sắp tới,không như tất cả mọi loài đều tìm cách chạy trốn cơn bão, chim đại bàng bay tới một đỉnh núi thật cao và đậu ở đó để chờ cơn bão tới, khi cơn bão ập tới con chim đại bàng đón đầu cơn bão, dùng chính sức mạnh của cơn bão để đưa đôi cánh mình bay vút lên bầu trời, cưỡi lên cơn bão đang gào thét bên dưới."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Ong" :@"question7.png" :@"Ong là loài côn trùng có tổ chức xã hội cao . Ong thường sống thành đàn, nhiều nhất có khi tới 25.000 – 50.000 con, trong các tổ ở hốc cây, kẽ đã, bụi rậm, trong rừng, hoặc các tổ hòm cải tiến do người nuôi làm cho nó ở. Ong chúa là con ong cái duy nhất có quyền đẻ trứng trong đàn o­ng, dài và to hơn các o­ng đực, ong thợ, cánh ngắn hơn thân, có nhiệm vụ đẻ trứng nhưng không làm ra mật, o­ng chúa nở từ một cái trứng như các trứng khác, nhưng ấu trùng được nuôi bắng tuyến nước bọt của ong thợ đặc biệt rất bổ, chứa trong một ổ riêng chỉ sử dụng cho ong chúa hoặc ong chuẩn bị phát triển thành ong chúa. Ong chúa sống 3 - 5 năm, mỗi tổ chỉ có một con o­ng chúa, nếu trong tổ có nhiều ong sẽ tách thành tổ mới, thường vào mùa xuân."]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Quạ" :@"question0.png" :@"Quạ có màu đen toàn thân, sống tại khắp nơi trên thế giới. Thức ăn tự nhiên của nhiều loài chim dạng quạ là thức ăn tạp, bao gồm động vật không xương sống, chim non, thú nhỏ, quả, hạt và xác thối. Quạ là những kẻ chiếm giữ lãnh thổ, chúng bảo vệ lãnh thổ trong suốt cả năm hoặc chỉ trong mùa sinh sản. "]];
            [_theList addObject:[[dongVat alloc] initWithName:@"Thiên nga" :@"question8.png" :@"Thiên nga thường kết đôi suốt đời. Thiên nga có bộ lông trắng tuyền hoặc lông trắng đen. Thiên nga được sử dụng nhiều trong văn học hay kịch."]];
        }
	}
	self.theList = [[NSMutableArray alloc] initWithArray:_theList];
}

- (NSInteger) numberOfProjects {
	return self.theList.count;
}




-(NSString *) animalName:(int) index
{
    dongVat *dongVat = [self.theList objectAtIndex:index];
    return dongVat.name;
}

-(NSString *) animalImage:(int) index
{
    dongVat *dongVat = [self.theList objectAtIndex:index];
    return dongVat.image;
}
-(NSString *) animalDescription:(int)index
{
    dongVat *dongVat = [self.theList objectAtIndex:index];
    return dongVat.description;
}

@end
