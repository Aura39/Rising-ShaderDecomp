float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler0, texcoord);
	r1 = r0.w + -0.0001;
	clip(r1);
	r1.x = dot(r0.xyz, 0.298912);
	r1.x = r1.x * g_Rate.x;
	r1.yzw = r0.xyz * g_MatrialColor.xyz;
	r0.xyz = r0.xyz * -g_MatrialColor.xyz + r0.xyz;
	o.xyz = r1.xxx * r0.xyz + r1.yzw;
	r1 = tex2D(g_Sampler1, texcoord);
	r0.x = r0.w * r1.w;
	o.w = r0.x * g_MatrialColor.w;

	return o;
}
