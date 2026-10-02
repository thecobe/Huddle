import { Module } from '@nestjs/common';
import { DevicesResolver } from './devices.resolver.js';

@Module({ providers: [DevicesResolver] })
export class DevicesModule {}
