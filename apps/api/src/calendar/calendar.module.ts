import { Module } from '@nestjs/common';
import { PeopleModule } from '../people/people.module.js';
import { CalendarFeedService } from './calendar-feed.service.js';
import { CalendarController } from './calendar.controller.js';
import { CalendarResolver } from './calendar.resolver.js';
import { CalendarService } from './calendar.service.js';

@Module({
  imports: [PeopleModule],
  controllers: [CalendarController],
  providers: [CalendarService, CalendarFeedService, CalendarResolver],
})
export class CalendarModule {}
