class User {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String address;
  final String summary;
  final List<String> skills;
  final List<Experience> experiences;
  final List<Education> educations;
  final List<String> interests;

  User.empty()
      : name = '',
        title = '',
        email = '',
        phone = '',
        address = '',
        summary = '',
        skills = [],
        experiences = [],
        educations = [],
        interests = [];

  User(
      this.name,
      this.title,
      this.email,
      this.phone,
      this.address,
      this.summary,
      this.skills,
      this.experiences,
      this.educations,
      this.interests,
      );
}

class Experience {
  final String position;
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  Experience(
      this.position,
      this.company,
      this.startDate,
      this.endDate,
      this.description,
      );
}

class Education {
  final String degree;
  final String institution;
  final String startDate;
  final String endDate;
  final String description;

  Education(
      this.degree,
      this.institution,
      this.startDate,
      this.endDate,
      this.description,
      );
}