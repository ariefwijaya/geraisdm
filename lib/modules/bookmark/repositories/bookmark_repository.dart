import 'package:geraisdm/modules/bookmark/models/bookmark_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/bookmark/providers/bookmark_provider_interface.dart';
import 'package:geraisdm/modules/bookmark/repositories/bookmark_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BookmarkRepositoryInterface)
class BookmarkRepository implements BookmarkRepositoryInterface {
  final BookmarkProviderInterface bookmarkProviderInterface;
  const BookmarkRepository({required this.bookmarkProviderInterface});
  @override
  Future<List<BookmarkModel>> getBookmark({PaginationControlModel? filter}) {
    return bookmarkProviderInterface.getBookmark(filter: filter);
  }
}
