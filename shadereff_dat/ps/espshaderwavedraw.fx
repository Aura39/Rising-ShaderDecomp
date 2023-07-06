float4 g_MatrialColor;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0.xy = 0.001953125 + texcoord.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0.x = r0.z * g_MatrialColor.w;
	o.xyz = r0.xxx * g_MatrialColor.xyz;
	o.w = 1;

	return o;
}
