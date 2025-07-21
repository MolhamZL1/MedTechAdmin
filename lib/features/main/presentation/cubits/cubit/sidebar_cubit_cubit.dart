import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/core/services/local_storage_service.dart';
import 'package:meta/meta.dart';

part 'sidebar_cubit_state.dart';

class SidebarCubit extends Cubit<bool> {
  SidebarCubit() : super(true) {
    _loadSidebarPreference();
  }

  void toggleSidebar() {
    final newState = !state;
    emit(newState);
    _saveSidebarPreference(newState);
  }

  void setSidebarState(bool isOpen) {
    emit(isOpen);
    _saveSidebarPreference(isOpen);
  }

  Future<void> _loadSidebarPreference() async {
    final isOpen =
        await LocalStorageService.getItem(LocalStorageKeys.sideBarState) ==
        "true";
    emit(isOpen);
  }

  Future<void> _saveSidebarPreference(bool isOpen) async {
    await LocalStorageService.setItem(
      LocalStorageKeys.sideBarState,
      isOpen == true ? "true" : "false",
    );
  }
}
