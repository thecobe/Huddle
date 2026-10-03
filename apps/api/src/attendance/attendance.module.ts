import { Module } from '@nestjs/common';
import { PeopleModule } from '../people/people.module.js';
import { AttendanceResolver } from './attendance.resolver.js';
import { AttendanceService } from './attendance.service.js';

@Module({
  imports: [PeopleModule],
  providers: [AttendanceService, AttendanceResolver],
})
export class AttendanceModule {}
