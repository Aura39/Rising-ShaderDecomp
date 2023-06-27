float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;

float4 main(float4 position : POSITION) : POSITION
{
	float4 o;

	float4 r0;
	r0.x = dot(position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(position, transpose(g_WorldMatrix)[3]);
	o.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	o.y = dot(r0, transpose(g_ViewProjMatrix)[1]);
	o.z = dot(r0, transpose(g_ViewProjMatrix)[2]);
	o.w = dot(r0, transpose(g_ViewProjMatrix)[3]);

	return o;
}
