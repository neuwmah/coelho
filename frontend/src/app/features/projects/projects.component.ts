import { Component, input } from '@angular/core';
import { Project } from '../../core/models/portfolio.models';
import { SectionHeadingComponent } from '../../shared/components/section-heading/section-heading.component';

@Component({
  selector: 'app-projects',
  standalone: true,
  imports: [SectionHeadingComponent],
  templateUrl: './projects.component.html',
  styleUrl: './projects.component.scss'
})
export class ProjectsComponent {
  readonly projects = input.required<Project[]>();

  private readonly iconsBySlug: Record<string, string> = {
    coelho: 'assets/icons/angular.svg',
    'mixmaster-pvp': 'assets/icons/react.svg',
    boxbox: 'assets/icons/flutter.svg',
    butterfly: 'assets/icons/csharp.svg',
    'ss-client': 'assets/icons/c.svg'
  };

  iconFor(slug: string): string | null {
    return this.iconsBySlug[slug] ?? null;
  }
}
