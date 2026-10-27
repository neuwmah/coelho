import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { environment } from '../../../environments/environment';
import {
  Bio,
  BioAttributes,
  ContactAttributes,
  ContactChannel,
  ContactChannelAttributes,
  ContactInfo,
  ContactPayload,
  Experience,
  ExperienceAttributes,
  HealthStatus,
  JsonApiResource,
  JsonApiResponse,
  Project,
  ProjectAttributes
} from '../models/portfolio.models';

@Injectable({
  providedIn: 'root'
})
export class PortfolioService {
  private readonly http = inject(HttpClient);
  private readonly baseUrl = environment.apiUrl;

  getHealth(): Observable<HealthStatus> {
    return this.http.get<HealthStatus>(`${this.baseUrl}/health`);
  }

  getBio(): Observable<Bio> {
    return this.http
      .get<JsonApiResponse<BioAttributes>>(`${this.baseUrl}/bio`)
      .pipe(map((response) => this.mapResource(response.data as JsonApiResource<BioAttributes>)));
  }

  getProjects(): Observable<Project[]> {
    return this.http
      .get<JsonApiResponse<ProjectAttributes>>(`${this.baseUrl}/projects`)
      .pipe(
        map((response) =>
          (response.data as JsonApiResource<ProjectAttributes>[]).map((item) => this.mapResource(item))
        )
      );
  }

  getProject(idOrSlug: string): Observable<Project> {
    return this.http
      .get<JsonApiResponse<ProjectAttributes>>(`${this.baseUrl}/projects/${idOrSlug}`)
      .pipe(map((response) => this.mapResource(response.data as JsonApiResource<ProjectAttributes>)));
  }

  getExperiences(): Observable<Experience[]> {
    return this.http
      .get<JsonApiResponse<ExperienceAttributes>>(`${this.baseUrl}/experiences`)
      .pipe(
        map((response) =>
          (response.data as JsonApiResource<ExperienceAttributes>[]).map((item) => this.mapResource(item))
        )
      );
  }

  getContact(): Observable<ContactInfo> {
    return this.http
      .get<JsonApiResponse<ContactAttributes>>(`${this.baseUrl}/contact`)
      .pipe(map((response) => this.mapResource(response.data as JsonApiResource<ContactAttributes>)));
  }

  getContactChannels(): Observable<ContactChannel[]> {
    return this.http
      .get<JsonApiResponse<ContactChannelAttributes>>(`${this.baseUrl}/contact_channels`)
      .pipe(
        map((response) =>
          (response.data as JsonApiResource<ContactChannelAttributes>[]).map((item) =>
            this.mapResource(item)
          )
        )
      );
  }

  sendContactMessage(payload: ContactPayload): Observable<unknown> {
    return this.http.post(`${this.baseUrl}/contact`, { contact: payload });
  }

  private mapResource<TAttributes extends object>(
    resource: JsonApiResource<TAttributes>
  ): TAttributes & { id: string } {
    return {
      id: resource.id,
      ...resource.attributes
    };
  }
}
