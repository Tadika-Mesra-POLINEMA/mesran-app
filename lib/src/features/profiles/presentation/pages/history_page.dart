import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_event.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_state.dart';
import 'package:mesran_app/src/features/profiles/presentation/widgets/invitation_card.dart';
import 'package:mesran_app/src/shared/presentation/widgets/custom_app_bar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<InvitationBloc>()..add(InvitationsLoad()),
      child: Scaffold(
        appBar: CustomAppBar(
          leadingText: 'Undanganku',
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder<InvitationBloc, InvitationState>(
            builder: (context, state) {
              if (state.events.isNotEmpty) {
                return ListView.separated(
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    final event = state.events[index];
                    return InvitationCard(
                      onTap: () {
                        context.push(
                            '/account/${event.id}/invitation'); // Gunakan event.id atau properti unik lainnya
                      },
                      content: InvitationContent(
                        name: event.name,
                        date: event.date,
                        desc: event.description,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(12),
                );
              } else if (state is InvitationLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Text(
                    'Tidak ada undangan yang tersedia.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: white,
      ),
    );
  }
}
