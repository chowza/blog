class ArticlesController < ApplicationController
	def index
		t = Time.now
		if params[:year].nil?
			#if year is nil just display last 10 articles
			@articles = Article.order('created_at DESC').limit(10)
		elsif params[:month].nil? && !params[:year].nil?
			# if year not nil but month is nil, then check if the year is valid

			if params[:year].to_i > t.year
				#redirect to 'error due to future'
			else
				#valid year, display that years most recent 10 articles 
				@articles = Article.order('created_at DESC').where("created_at <? AND created_at >=?", Time.mktime(params[:year].to_i+1, 1),Time.mktime(params[:year].to_i, 1)).limit(10)
			end
		elsif params[:month].nil? && params[:year].nil?
			# if month nil & year nil just display last 10 articles
			@articles = Article.order('created_at DESC').limit(10)
		else
			# year and month is not nil 			
			if params[:year].to_i > t.year
				#redirect to 'errorpage due to future'
			
			elsif params[:month].to_i > 12
				# redirect to 'errorpage due month > 12'
			elsif params[:month].to_i == 0
				# redirect to errorpage due to month = 0
			elsif params[:year].to_i == t.year && params[:month].to_i > t.month 
				# redirect to 'errorpage due to future'
			else
				#month is valid and year is valid, display articles from the month selected
				if params[:month].to_i == 12
					@articles = Article.order('created_at DESC').where("created_at <? AND created_at >=?", Time.mktime(params[:year].to_i+1, 1),Time.mktime(params[:year], params[:month])) 
				else
					@articles = Article.order('created_at DESC').where("created_at <? AND created_at >=?", Time.mktime(params[:year], params[:month].to_i+1),Time.mktime(params[:year], params[:month])) 
				end

			end
		end
	end

	def new
		@article = Article.new
	end
	def create
		@article = Article.new(params[:article])
		if @article.save
			redirect_to articles_path
		else
			redirect_to new_article_path
		end
	end

	def edit
		@article = Article.find_by_slug(params[:id])
	end
	def update
		@article = Article.find_by_slug(params[:id])
		if @article.update_attributes(params[:article])
			redirect_to posts_date_path(@article.created_at.year,@article.created_at.month,@article.slug)
		else
			redirect_to edit_article_path(params[:id])
		end
	end

	def show
		@article = Article.find_by_slug(params[:slug])
		if params[:month].to_i !=@article.created_at.month || params[:year].to_i !=@article.created_at.year
			@article = nil
		end
	end

	def tableofcontents
		render layout: 'noheader'
	end

	def errors
	end
end
