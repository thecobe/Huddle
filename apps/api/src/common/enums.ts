import { registerEnumType } from '@nestjs/graphql';

export enum MembershipRoleEnum {
  ADMIN = 'ADMIN',
  SECRETARY = 'SECRETARY',
  SPORTS_DIRECTOR = 'SPORTS_DIRECTOR',
  COACH = 'COACH',
  TEAM_MANAGER = 'TEAM_MANAGER',
  ATHLETE = 'ATHLETE',
  PARENT = 'PARENT',
}
registerEnumType(MembershipRoleEnum, { name: 'MembershipRole' });

export enum SeasonStatusEnum {
  PLANNED = 'PLANNED',
  OPEN = 'OPEN',
  CLOSED = 'CLOSED',
}
registerEnumType(SeasonStatusEnum, { name: 'SeasonStatus' });

export enum DevicePlatformEnum {
  IOS = 'IOS',
  ANDROID = 'ANDROID',
  WEB = 'WEB',
}
registerEnumType(DevicePlatformEnum, { name: 'DevicePlatform' });

export enum ConsentKindEnum {
  PRIVACY_POLICY = 'PRIVACY_POLICY',
  TERMS_OF_SERVICE = 'TERMS_OF_SERVICE',
  IMAGE_RELEASE = 'IMAGE_RELEASE',
  MARKETING = 'MARKETING',
}
registerEnumType(ConsentKindEnum, { name: 'ConsentKind' });

export enum PersonGenderEnum {
  F = 'F',
  M = 'M',
}
registerEnumType(PersonGenderEnum, { name: 'PersonGender' });

export enum PersonCategoryEnum {
  ATHLETE = 'ATHLETE',
  STAFF = 'STAFF',
  MANAGER = 'MANAGER',
  VOLUNTEER = 'VOLUNTEER',
  GUARDIAN = 'GUARDIAN',
}
registerEnumType(PersonCategoryEnum, { name: 'PersonCategory' });

export enum GuardianRelationEnum {
  MOTHER = 'MOTHER',
  FATHER = 'FATHER',
  GUARDIAN = 'GUARDIAN',
  OTHER = 'OTHER',
}
registerEnumType(GuardianRelationEnum, { name: 'GuardianRelation' });

export enum PlayerAvailabilityEnum {
  AVAILABLE = 'AVAILABLE',
  INJURED = 'INJURED',
  SUSPENDED = 'SUSPENDED',
  OTHER = 'OTHER',
}
registerEnumType(PlayerAvailabilityEnum, { name: 'PlayerAvailability' });

export enum StaffRoleEnum {
  HEAD_COACH = 'HEAD_COACH',
  ASSISTANT_COACH = 'ASSISTANT_COACH',
  FITNESS_COACH = 'FITNESS_COACH',
  GOALKEEPER_COACH = 'GOALKEEPER_COACH',
  TEAM_MANAGER = 'TEAM_MANAGER',
}
registerEnumType(StaffRoleEnum, { name: 'StaffRole' });
