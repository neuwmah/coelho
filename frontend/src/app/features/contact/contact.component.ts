import { Component, input } from '@angular/core';
import { ContactChannel } from '../../core/models/portfolio.models';
import { SectionHeadingComponent } from '../../shared/components/section-heading/section-heading.component';

@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [SectionHeadingComponent],
  templateUrl: './contact.component.html',
  styleUrl: './contact.component.scss'
})
export class ContactComponent {
  readonly channels = input.required<ContactChannel[]>();
}
