import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/domain/entities/event.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/profile_data_source.dart';
import 'package:mesran_app/src/features/profiles/domain/entity/user.dart';
import 'package:mesran_app/src/features/profiles/domain/repository/abstract_profile_repository.dart';

class ProfileRepositoryImpl extends AbstractProfileRepository {
  final ProfileDataSource _profileDataSource;
  ProfileRepositoryImpl(this._profileDataSource);
  @override
  Future<Either<Null, User>> getProfile() async {
    return await _profileDataSource.fetchProfile();
  }
}
