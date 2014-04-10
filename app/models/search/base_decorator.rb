Spree::Core::Search::Base.class_eval do
  cattr_accessor :last_durably_decorate

  @@last_durably_decorate ||= DurableDecorator::Base.determine_sha('Spree::Core::Search::Base#get_base_scope')

  protected

  durably_decorate :get_base_scope, mode: 'soft', sha: DurableDecorator::Base.determine_sha('Spree::Core::Search::Base#get_base_scope') do
    base_scope = send("_#{Spree::Core::Search::Base.last_durably_decorate}_get_base_scope").visible
    taxon && !taxon.visible ? base_scope.none : base_scope
  end
end
