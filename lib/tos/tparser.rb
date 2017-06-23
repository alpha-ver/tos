module Tos
  class Tparser < Agent

    def initialize(query, params={})
      set_params(params)
      set_query(query)
      @results = get_results(@params[:api_enabled])
    end

    #get params castomizate
    def self.default_params
      set_params
      @params
    end

    def results
      @results.map{ |result|
        if result_name?(result) && result_include?(result) && result_exclude?(result)
          result
        end
      }.compact
    end



    private

      def get_results(id=nil)
        if id.class == Integer
          ids = [id]
        elsif id.class == Array
          ids = id
        elsif id.nil?
          ids = @params[:api_enabled]
        else
          raise Error.new('Undefine type id in function get_result. [Integer/Array/Nil]')
        end

        ids.map { |item|
          get_result(item).map{ |i|
            {
              :name      => ActionController::Base.helpers.sanitize(i[:name], tags: []).to_str,
              :file_type => @params[:file_types][i[:z].to_i],
              :category  => i[:k],
              :size_kb   => i[:sk].gsub(',', '.').to_f,
              :seeds     => i[:s].to_i,
              :leechers  => i[:l].to_i,
              :link      => i[:link],
              :magnet    => magnet(i, item),
              :t_id      => i[:d].to_i,
              :tracker   => @params[:api][item][:key]
            }
          }
        }.flatten(2)

      end


      def get_result(id)
        uri      = generate_uri(id)
        response = http(uri).force_encoding("UTF-8")
        h        = eval(response)

        if !h.nil? && !h[:sr].nil? && h[:sr].class == Array && h[:sr][0][:error] != '1'
          h[:sr]
        else
          []
        end
      end

      def one(pp)
        pp
      end

      def generate_uri(id)
        uri       = URI(@params[:api][id][:url])
        query     = @params[:params].merge({ @params[:query] => @query.join(" ") }) # ^_^
        uri.query = URI.encode_www_form( query )

        uri
      end

      def magnet(i, iid)
        if @params[:api][iid][:magnet] && i[:m].nil?
          id           = "#{i[:img].to_s.length}#{i[:img]}#{i[:d]}"
          uri          = URI("#{@params[:magnet][:url]}?#{@params[:magnet][:query]}=#{id}")
          response     = http(uri)

          response
        elsif !i[:m].nil?
          i[:m]
        else
          0
        end
      end

      #def size(s, name)
      #  size_f = s.to_f
      #  if name == "GB"
      #    size_f = size_f * 1024
      #  elsif name == "MB"
      #    # ok
      #  else
      #    raise Error.new("Error func size() -> #{s} #{name}")
      #  end
      #end

      def set_params(params={})
        @params_key = :tparser
        @params     = PARAMS[@params_key].merge(params)
      end

      def set_query(query)
        if query.class == String
          @query = [query]
        elsif query.class == Array
          @query = query
        else
          raise Error.new('Undefine type query. [Integer/Array]')
        end
      end

      def result_include?(h)
        !@params[:include].map{|pk,pv|
          if pv.class == Array
            pv.map{|v|
              inc?(pk, v, h)
            }
          else
            inc?(pk, pv, h)
          end
        }.flatten.include?(false)
      end

      def result_exclude?(h)
        !@params[:exclude].map{|pk,pv|
          if pv.class == Array
            pv.map{|v|
              inc?(pk, v, h)
            }
          else
            inc?(pk, pv, h)
          end
        }.flatten.include?(true)
      end

      def inc?(k, v, h)
        if h[k].class == String
          !h[k].match(v).nil?
        elsif h[k].class == Symbol
          h[k] == v
        else
          true
        end
      end

      def result_name?(h)
        names = @query.each {|i|
          if !h[:name].include?(i)
            break
          end
        }

        if names.nil?
          false
        else
          true
        end

      end


  end
end
