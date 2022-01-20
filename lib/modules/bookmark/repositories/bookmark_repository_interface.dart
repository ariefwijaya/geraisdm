import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/bookmark/models/bookmark_model.dart';

abstract class BookmarkRepositoryInterface {
  Future<List<BookmarkModel>> getBookmark({PaginationControlModel? filter});
}
