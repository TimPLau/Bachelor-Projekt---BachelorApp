// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/challenge_tool_data.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';

import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/reducers/app_reducer.dart';

void main() {
  group('Milestone Reducer', () {
    test('Add Milestone to Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone newMilestone =
          new Milestone("Milestone", DateTime(2018, 07, 27));

      expect(store.state.currentMilestones.isEmpty, true);

      store.dispatch(new AddMilestoneAction(newMilestone));

      expect(store.state.currentMilestones.containsKey(newMilestone.id), true);
      expect(store.state.currentMilestones[newMilestone.id].date,
          newMilestone.date);
      expect(store.state.currentMilestones[newMilestone.id].title,
          newMilestone.title);
    });

    test('Remove Milestone from Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone newMilestone =
          new Milestone("Milestone", DateTime(2018, 07, 27));

      expect(store.state.currentMilestones.isEmpty, true);

      store.dispatch(new AddMilestoneAction(newMilestone));

      expect(store.state.currentMilestones.isEmpty, false);

      expect(store.state.currentMilestones.containsKey(newMilestone.id), true);
      expect(store.state.currentMilestones[newMilestone.id].date,
          newMilestone.date);
      expect(store.state.currentMilestones[newMilestone.id].title,
          newMilestone.title);
      expect(store.state.currentMilestones[newMilestone.id].id,
          DateTime(2018, 07, 27).toIso8601String());

      store.dispatch(new RemoveMilestoneAction(newMilestone));

      expect(store.state.currentMilestones.isEmpty, true);
    });

    test('Edit Milestone on Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone milestone =
          new Milestone("Milestone 1", DateTime(2018, 07, 27));

      expect(store.state.currentMilestones.isEmpty, true);
      store.dispatch(new AddMilestoneAction(milestone));

      store.dispatch(new EditMilestoneAction(milestone, "Milestone 2",
          DateTime(2018, 08, 27), "Milestone 2 Description"));

      expect(
          store.state.currentMilestones
              .containsKey(DateTime(2018, 08, 27).toIso8601String()),
          true);
      expect(
          store
              .state
              .currentMilestones[DateTime(2018, 08, 27).toIso8601String()]
              .title,
          "Milestone 2");
      expect(
          store
              .state
              .currentMilestones[DateTime(2018, 08, 27).toIso8601String()]
              .description,
          "Milestone 2 Description");
      expect(store.state.currentMilestones.length, 1);
    });

    test('Add Task to Milestone on Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone milestone =
          new Milestone("Milestone 1", DateTime(2018, 07, 27));
      store.dispatch(new AddMilestoneAction(milestone));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 0);

      Task task = new Task("Task 1", TaskState.notCompleted);
      store.dispatch(new AddTaskAction(milestone, task));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 1);
      expect(store.state.currentMilestones[milestone.id].tasks[task.id].title,
          task.title);
      expect(
          store.state.currentMilestones[milestone.id].tasks[task.id].taskState,
          task.taskState);
    });

    test('Remove Task from Milestone on Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone milestone =
          new Milestone("Milestone 1", DateTime(2018, 07, 27));
      store.dispatch(new AddMilestoneAction(milestone));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 0);

      Task task = new Task("Task 1", TaskState.notCompleted);
      store.dispatch(new AddTaskAction(milestone, task));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 1);

      store.dispatch(new RemoveTaskAction(milestone, task));

      expect(store.state.currentMilestones[milestone.id].tasks.length, 0);
    });

    test('Edit Task from Milestone on Store', () {
      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: informationToolContentBuilder.rootContent,
            currentMilestones: new SplayTreeMap<String, Milestone>(),
            properties: AchievementLookUp.properties,
            achievedAchievements: achievedAchievements,
            challenges: ChallengesLookUp.challenges,
            begin: null,
            end: null),
      );

      Milestone milestone =
          new Milestone("Milestone 1", DateTime(2018, 07, 27));
      store.dispatch(new AddMilestoneAction(milestone));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 0);

      Task task = new Task("Task 1", TaskState.notCompleted);
      store.dispatch(new AddTaskAction(milestone, task));
      expect(store.state.currentMilestones[milestone.id].tasks.length, 1);

      store.dispatch(new EditTaskAction(milestone, task, "New Task 1 Title"));

      expect(store.state.currentMilestones[milestone.id].tasks[task.id].title,
          "New Task 1 Title");
    });
  });

  group('Information Tool Reducer', () {
    //No Reducer Actions
  });

  group('Achievement/Challenge Reducers', () {
    test('Check Challenge Achievement from Store', () {

      Challenge c1 = new Challenge("Beginne deine Einleitung",
          "Beginne deine Einleitung Beschreibung");
      Challenge c2 = new Challenge("Beginne deine Zweileitung",
          "Beginne deine Zweileitung Beschreibung");

      Property prop = new Property("Beginne deine Einleitung", 0, ACTIVE_IF_EQUALS_TO, 1);
      Achievement achievement = new Achievement("Beginne deine Einleitung", AchievementType.low, [prop]);
      Map<String, Achievement> achievements = {
        achievement.title : achievement
      };

      Map<String, Map<String, Achievement>> achievementState = {
        "Recognized": {},
        "NotRecognized": {},
        "Achieved": {},
        "AllAchievements": achievements,
      };

      Map<String, Challenge> challenges = {
        c1.title : c1,
        c2.title : c2,
      };

      Store<AppState> store = new Store<AppState>(
        appReducer,
        initialState: new AppState(
            informationToolContent: null,
            currentMilestones: {},
            properties: {prop.name:prop},
            achievedAchievements: achievementState,
            challenges: challenges,
            begin: null,
            end: null),
      );

      expect(store.state.challenges[c1.title].title, "Beginne deine Einleitung");
      expect(store.state.challenges[c1.title].description, "Beginne deine Einleitung Beschreibung");
      expect(store.state.challenges[c1.title].completed, false);

      expect(store.state.challenges[c2.title].title, "Beginne deine Zweileitung");
      expect(store.state.challenges[c2.title].description, "Beginne deine Zweileitung Beschreibung");
      expect(store.state.challenges[c2.title].completed, false);

      store.dispatch(new ChangeStateChallengeAction(c1));

      expect(store.state.challenges[c1.title].title, "Beginne deine Einleitung");
      expect(store.state.challenges[c1.title].description, "Beginne deine Einleitung Beschreibung");
      expect(store.state.challenges[c1.title].completed, true);

      expect(store.state.challenges[c2.title].title, "Beginne deine Zweileitung");
      expect(store.state.challenges[c2.title].description, "Beginne deine Zweileitung Beschreibung");
      expect(store.state.challenges[c2.title].completed, false);

    });
  });
}
