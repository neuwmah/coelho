export interface JsonApiResource<TAttributes> {
  id: string;
  type: string;
  attributes: TAttributes;
}

export interface JsonApiResponse<TAttributes> {
  data: JsonApiResource<TAttributes> | JsonApiResource<TAttributes>[];
}

export interface BioAttributes {
  full_name: string;
  headline: string;
  summary: string;
  summary_mobile: string;
  location: string;
  skills: string[];
  avatar_url: string | null;
  resume_url: string | null;
}

export interface ProjectAttributes {
  title: string;
  slug: string;
  summary: string;
  description: string | null;
  tech_stack: string[];
  repo_url: string | null;
  live_url: string | null;
  featured: boolean;
  position: number;
}

export interface ExperienceAttributes {
  company: string;
  role: string;
  location: string | null;
  started_on: string;
  ended_on: string | null;
  current: boolean;
  description: string | null;
  highlights: string[];
}

export interface ContactAttributes {
  email: string;
  phone: string | null;
  location: string;
  linkedin_url: string | null;
  github_url: string | null;
  twitter_url: string | null;
}

export interface ContactChannelAttributes {
  title: string;
  subtitle: string;
  icon: string;
  href: string | null;
  position: number;
}

export interface Bio extends BioAttributes {
  id: string;
}

export interface Project extends ProjectAttributes {
  id: string;
}

export interface Experience extends ExperienceAttributes {
  id: string;
}

export interface ContactInfo extends ContactAttributes {
  id: string;
}

export interface ContactChannel extends ContactChannelAttributes {
  id: string;
}

export interface ContactPayload {
  name: string;
  email: string;
  message: string;
}

export interface HealthStatus {
  status: string;
  service: string;
  timestamp: string;
  version: string;
}
