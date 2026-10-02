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
