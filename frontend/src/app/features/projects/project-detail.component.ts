import { AsyncPipe } from '@angular/common';
import { Component, inject } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { catchError, of, switchMap } from 'rxjs';
import { PortfolioService } from '../../core/services/portfolio.service';

@Component({
  selector: 'app-project-detail',
  standalone: true,
  imports: [AsyncPipe, RouterLink],
  templateUrl: './project-detail.component.html',
  styleUrl: './project-detail.component.scss'
})
export class ProjectDetailComponent {
  private readonly route = inject(ActivatedRoute);
  private readonly portfolioService = inject(PortfolioService);

  readonly project$ = this.route.paramMap.pipe(
    switchMap((params) => {
      const slug = params.get('slug') ?? '';
      return this.portfolioService.getProject(slug).pipe(catchError(() => of(null)));
    })
  );
}
