flutter_bloc (Cubit): Quản lý state theo mô hình BLoC, tách UI và business logic, giảm rebuild không cần thiết.
Equatable: So sánh state theo giá trị, tối ưu việc rebuild UI trong Bloc/Cubit.
Dio: Thực hiện HTTP request, cấu hình base URL, timeout và interceptor cho việc gọi API.
Retrofit: Định nghĩa API dưới dạng interface, tự động generate code gọi Dio, giúp code dễ bảo trì.
Repository Pattern: Tách layer truy cập dữ liệu, che giấu nguồn dữ liệu (API), giúp Bloc độc lập với network layer.
get_it & injectable: Quản lý dependency injection, tự động đăng ký và cung cấp các service, repository cho Bloc/Cubit.
json_serializable: Tự động sinh code parse JSON, giảm code thủ công và hạn chế lỗi khi mapping dữ liệu.
Firebase Authentication: Xác thực người dùng và quản lý phiên đăng nhập.
