import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, id;
  final Color color;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Chú Thuật Hồi Chiến - Tập 6",
      price: 27100,
      description:
          "Phía Kyoto lợi dụng cơ hội giao lưu để trừ khử Itadori. Trong lúc đó, chú nguyền sư và chú linh do Mahito cầm đầu đã đột nhập vào khu vực diễn ra buổi giao lưu. Nhóm giáo viên định tới ứng cứu học sinh nhưng lại bị “màn” của phe địch cản bướ!? Bị chú linh đặc cấp Hanami tấn công, liệu Fushiguro và Inumaki có thoát khỏi vòng nguy hiểm!",
      image: "assets/images/1.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Blue Period - Tập 01",
      price: 23000,
      description:
          "Mùa xuân lớp 12, thời điểm các sĩ tử đứng trước ngã rẽ cuộc đời.\nIchinose Taichi được xếp vào cùng lớp với Kuze Futaba - người cậu có cảm giác không thể hòa hợp mà chẳng rõ lí do tại sao, cùng Mita Touma - người bạn sống thực tế mà cậu quen từ thuở ấu thơ. Tới một ngày, Futaba nói cho Taichi biết tình cảm của mình dành cho Touma và nhờ cậu giúp đỡ. Taichi sẽ làm gì trước tình cảnh này…!?",
      image: "assets/images/2.jpg",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "Toàn Thư Chiêm Tinh Học Nhập Môn",
      price: 52000,
      description:
          "Hơn nửa đời người hành nghề chiêm tinh, tôi nhận ra rằng: Ai trong chúng ta đều muốn hiểu rõ hơn chính là bản thân mình. Bạn chắc chắn đã từng tự hỏi “Tôi là ai?”,  bạn muốn biết động cơ nào đang thúc đẩy mình, tại sao cảm xúc, trực giác lúc đó của bạn lại mạnh mẽ đến vậy, và những người khác có mặc cảm về bản thân như bạn không. Người ta thường viết thư cho tôi để hỏi rằng “Tôi nên tìm kiếm người đàn ông như thế nào?”,  “Tại sao tôi lại bất mãn với công việc của mình vậy?”. Nhưng sau đó thì sao?",
      image: "assets/images/3.jpg",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Yêu nhưng không hoàn hảo",
      price: 45000,
      description:
          "Yêu Những Điều Không Hoàn Hảo\nĐại đức Hae Min sinh ra và lớn lên tại Hàn Quốc. Sau khi hoàn thành bằng Thạc sĩ Tôn giáo học đối chiếu ở Đại học Havard và Tiến sĩ Tôn giáo học ở Đại học Princeton, ông ở lại Mỹ tham gia giảng dạy về tôn giáo ở trường Đại học Hampshire, Massachusetts. Không chỉ dừng lại ở nghiên cứu lý thuyết, mùa xuân năm 2000 ông quyết định xuất gia theo tông phái Tào Khê, một tông phái tiêu biểu của Phật giáo Hàn Quốc. ",
      image: "assets/images/4.jpg",
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Thao Túng Tâm Lý",
      price: 200000,
      description:
          "<p>Trong cuốn “Thao túng tâm lý”, tác giả Shannon Thomas giới thiệu đến độc giả những hiểu biết liên quan đến thao túng tâm lý và lạm dụng tiềm ẩn. </p>\n<p>“Thao túng tâm lý” là một dạng của lạm dụng tâm lý. Cũng giống như lạm dụng tâm lý, thao túng tâm lý có thể xuất hiện ở bất kỳ môi trường nào, từ bất cứ đối tượng độc hại nào. Đó có thể là bố mẹ ruột, anh chị em ruột, người yêu, vợ hoặc chồng, sếp hay đồng nghiệp… của bạn.",
      image: "assets/images/5.jpg",
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Điềm tĩnh và nóng giận",
    price: 150000,
    description:
        "Trong cuộc sống thường ngày, chúng ta thường nổi giận vì nhiều nguyên do: công việc không suôn sẻ; bị người khác hiểu nhầm; thấy việc chướng tai gai mắt; không thể chấp nhận được dư luận xã hội. Thậm chí, chúng ta bực tức, cáu gắt, hờn dỗi, nhỏ nhen, uất ức vì thời tiết xấu, vì tiền lương thấp, vì nhà cửa bừa bộn, vì thái độ của người khác, vì những chuyện không may mà mình gặp phải. Dường như cuộc đời chúng ta là một chuỗi tức giận không hồi kết. Hãy thử tự hỏi bản thân: sau khi tức giận thì phiền não sẽ tan biến ư?",
    image: "assets/images/6.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
