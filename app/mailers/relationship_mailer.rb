class RelationshipMailer < ApplicationMailer
    def new_comment(user, comments)
        @user = user
        @comments = comments
        mail to: user.email, subject: '【お知らせ】コメントされました'
    end
end