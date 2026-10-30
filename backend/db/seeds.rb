Bio.destroy_all
Contact.destroy_all
ContactChannel.destroy_all
Project.destroy_all
Experience.destroy_all
ContactMessage.destroy_all

Bio.create!(
  full_name: "Guilherme Neumann",
  headline: "Full-Stack Developer",
  summary: "Six years of professional development experience and five of lead.\nI have a lot of code knowledge from web frameworks to windows kernel development.\nActive repositories are currently private.",
  summary_mobile: "Six years of professional development experience and five of lead. I have a lot of code knowledge from web frameworks to windows kernel development.\nActive repositories are currently private.",
  location: "OPEN TO WORK",
  skills: [
    "JavaScript/HTML/CSS",
    "TypeScript/React/Angular",
    "C#/C++/Python",
    "x86 Assembly",
    "PostgreSQL/MySQL",
    "Flutter/Dart",
    "Firebase/AdMob",
    "Linux/Windows Driver"
  ],
  avatar_url: "/assets/avatar.png",
  resume_url: nil
)

Contact.create!(
  email: "neuwmah@gmail.com",
  phone: "+55 51 99256-3706",
  location: "Cachoeirinha/RS, BR 94920-520",
  linkedin_url: "https://linkedin.com/in/guilherme-neumann",
  github_url: "https://github.com/neuwmah",
  twitter_url: nil
)

ContactChannel.create!(
  [
    {
      title: "Gmail",
      subtitle: "neuwmah@gmail.com",
      icon: "assets/icons/gmail.svg",
      href: "mailto:neuwmah@gmail.com",
      position: 1
    },
    {
      title: "WhatsApp",
      subtitle: "+5551992563706",
      icon: "assets/icons/whatsapp.svg",
      href: "https://wa.me/5551992563706",
      position: 2
    },
    {
      title: "LinkedIn",
      subtitle: "Guilherme Neumann",
      icon: "assets/icons/linkedin.svg",
      href: "https://linkedin.com/in/guilherme-neumann",
      position: 3
    },
    {
      title: "Discord",
      subtitle: "2014",
      icon: "assets/icons/discord.svg",
      href: "https://discord.com/users/1187937891075231864",
      position: 4
    },
    {
      title: "GitHub",
      subtitle: "neuwmah",
      icon: "assets/icons/github.svg",
      href: "https://github.com/neuwmah",
      position: 5
    }
  ]
)

Project.create!(
  [
    {
      title: "Current Website",
      slug: "coelho",
      summary: "Side project — 2026",
      description: nil,
      tech_stack: ["angular", "ruby on rails", "typescript", "postgresql", "scss", "docker"],
      repo_url: "https://github.com/neuwmah/coelho",
      live_url: nil,
      featured: true,
      position: 1
    },
    {
      title: "Recreational Website",
      slug: "mixmaster-pvp",
      summary: "Side project — 2025",
      description: nil,
      tech_stack: %w[react nextjs tailwind typescript mysql postgresql prisma],
      repo_url: "https://github.com/neuwmah/mixmaster-pvp",
      live_url: nil,
      featured: true,
      position: 2
    },
    {
      title: "Mobile Game App",
      slug: "boxbox",
      summary: "Side project — 2026 - Present",
      description: nil,
      tech_stack: %w[flutter dart javascript express postgresql firebase admob],
      repo_url: "https://github.com/neuwmah/boxbox",
      live_url: nil,
      featured: true,
      position: 3
    },
    {
      title: "Server Reconnect System",
      slug: "butterfly",
      summary: "Side project — 2026",
      description: nil,
      tech_stack: %w[csharp dotnet wpf xaml npgsql],
      repo_url: "https://github.com/neuwmah/butterfly",
      live_url: nil,
      featured: true,
      position: 4
    },
    {
      title: "Memory Hook Tool",
      slug: "ss-client",
      summary: "Side project — 2026",
      description: nil,
      tech_stack: ["c", "ghidra", "hxd", "binary analysis", "reverse engineering"],
      repo_url: "https://github.com/neuwmah/ss-client",
      live_url: nil,
      featured: false,
      position: 5
    }
  ]
)

Experience.create!(
  [
    {
      company: "Self-Employed",
      role: "Full-Stack Developer",
      location: "Remote",
      started_on: Date.new(2025, 12, 1),
      ended_on: nil,
      current: true,
      description: nil,
      highlights: [
        "Independently developing proprietary systems for legacy online game servers with no source.",
        "Performing binary analysis, memory inspection, and reverse engineering to patch, optimize, and extend default core application capabilities.",
        "Managing full-stack workflows, handling performance optimization, database structures, and client delivery from conception to support."
      ]
    },
    {
      company: "Olist",
      role: "Tech Lead & Senior Developer",
      location: "Porto Alegre, BR",
      started_on: Date.new(2020, 10, 1),
      ended_on: Date.new(2025, 10, 31),
      current: false,
      description: nil,
      highlights: [
        "Started as junior frontend developer with basic JS/HTML/CSS knowledge and learned Shopify Liquid template engine while building custom websites from scratch. Pages like home, list, product, cart, everything designed for ecommerce websites and customer issues.",
        "After a year, I went from a mid level developer role to tech lead of customer success developers team, switching from websites build/release to leading the squad responsible for active merchant operations and technical support requests. Used to lead ecommerce build teams later too.",
        "Developed 77 original ecommerce websites. Mobile first with fixes for specific devices and tests via BrowserStack. Development experience with Google tools like Tag Manager, Analytics, Business, Search Console, Rich Results and third party solutions for reviews. Deep expertise in web performance optimization and analysis using PageSpeed Insights and WebPageTest. Also worked on internal company components."
      ]
    }
  ]
)

puts "Seeded bio, contact, #{ContactChannel.count} contact channels, #{Project.count} projects, and #{Experience.count} experiences."
