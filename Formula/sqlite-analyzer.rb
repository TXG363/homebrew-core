class SqliteAnalyzer < Formula
  desc "Analyze how space is allocated inside an SQLite file"
  homepage "https://www.sqlite.org/"
  url "https://www.sqlite.org/2017/sqlite-src-3160000.zip"
  version "3.16.0"
  sha256 "9aa6c30e350e3f9729ea56a63b5ec7eb7e5cd63ca63b34fa6784b7800ce25ad0"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f23970781fddb82bc783dfb7729bfe80aca64465a8900e81e80239b247e296f" => :sierra
    sha256 "190b49894b478553f8bd8f39f92528d4b14bc761459779bd4e2cc045cd53b840" => :el_capitan
    sha256 "1197dc8a2426c8edcd1a7d7169d70ee5e10bff676400dcc76fa0e2c371691c41" => :yosemite
  end

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "sqlite3_analyzer"
    bin.install "sqlite3_analyzer"
  end

  test do
    dbpath = testpath/"school.sqlite"
    sqlpath = testpath/"school.sql"
    sqlpath.write <<-EOS.undent
      create table students (name text, age integer);
      insert into students (name, age) values ('Bob', 14);
      insert into students (name, age) values ('Sue', 12);
      insert into students (name, age) values ('Tim', 13);
    EOS
    system "/usr/bin/sqlite3 #{dbpath} < #{sqlpath}"
    system bin/"sqlite3_analyzer", dbpath
  end
end
