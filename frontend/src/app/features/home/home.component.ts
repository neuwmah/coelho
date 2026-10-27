import { afterNextRender, Component, computed, inject, signal } from '@angular/core';
import { toObservable } from '@angular/core/rxjs-interop';
import { catchError, filter, firstValueFrom, of, timeout } from 'rxjs';
import { Bio, ContactChannel, Experience, Project } from '../../core/models/portfolio.models';
import { PortfolioService } from '../../core/services/portfolio.service';
import { SectionScrollService } from '../../core/services/section-scroll.service';
import { ContactComponent } from '../contact/contact.component';
import { ExperienceComponent } from '../experience/experience.component';
import { ProjectsComponent } from '../projects/projects.component';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [ProjectsComponent, ExperienceComponent, ContactComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent {
  private readonly portfolioService = inject(PortfolioService);
  private readonly sectionScroll = inject(SectionScrollService);

  readonly bio = signal<Bio | null>(null);
  readonly bioReady = signal(false);
  readonly experiences = signal<Experience[] | undefined>(undefined);
  readonly projects = signal<Project[] | undefined>(undefined);
  readonly channels = signal<ContactChannel[] | undefined>(undefined);

  readonly showExperience = computed(() => this.bioReady() && this.experiences() !== undefined);
  readonly showProjects = computed(() => this.showExperience() && this.projects() !== undefined);
  readonly showContact = computed(() => this.showProjects() && this.channels() !== undefined);

  private readonly sectionsReady$ = toObservable(
    computed(() => ({
      home: this.bioReady(),
      experience: this.showExperience(),
      projects: this.showProjects(),
      contact: this.showContact()
    }))
  );

  constructor() {
    this.portfolioService.getBio().pipe(catchError(() => of(null))).subscribe((data) => {
      this.bio.set(data);
      this.bioReady.set(true);
    });
    this.portfolioService.getExperiences().pipe(catchError(() => of([]))).subscribe((data) => {
      this.experiences.set(data);
    });
    this.portfolioService.getProjects().pipe(catchError(() => of([]))).subscribe((data) => {
      this.projects.set(data);
    });
    this.portfolioService.getContactChannels().pipe(catchError(() => of([]))).subscribe((data) => {
      this.channels.set(data);
    });

    afterNextRender(() => {
      void this.restoreHashScroll();
    });
  }

  goSection(fragment: string, event: Event): void {
    event.preventDefault();
    void this.sectionScroll.scrollToSection(fragment, 'smooth');
  }

  private async restoreHashScroll(): Promise<void> {
    const fragment = this.sectionScroll.consumePendingHash();
    if (!fragment || fragment === 'home') {
      return;
    }

    try {
      await firstValueFrom(
        this.sectionsReady$.pipe(
          filter((ready) => ready[fragment as keyof typeof ready] ?? ready.home),
          timeout(5000)
        )
      );
    } catch {
      return;
    }

    await new Promise<void>((resolve) => {
      requestAnimationFrame(() => {
        requestAnimationFrame(() => resolve());
      });
    });

    await this.sectionScroll.scrollToSection(fragment, 'auto');
  }
}
