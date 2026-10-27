import { DatePipe } from '@angular/common';
import { Component, input } from '@angular/core';
import { Experience } from '../../core/models/portfolio.models';
import { SectionHeadingComponent } from '../../shared/components/section-heading/section-heading.component';

@Component({
  selector: 'app-experience',
  standalone: true,
  imports: [DatePipe, SectionHeadingComponent],
  templateUrl: './experience.component.html',
  styleUrl: './experience.component.scss'
})
export class ExperienceComponent {
  readonly experiences = input.required<Experience[]>();
}
