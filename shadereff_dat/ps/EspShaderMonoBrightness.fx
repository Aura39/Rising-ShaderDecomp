float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r1.x = max(r0.x, r0.y);
	r2.x = max(r1.x, r0.z);
	r1.x = r2.x * g_Rate.x;
	r0.x = dot(r0.xyz, 0.298912);
	r0.x = r1.x * r0.x;
	r0.x = r0.x * 0.39215687;
	o.xyz = r0.xxx * g_MatrialColor.xyz;
	r1.w = g_MatrialColor.w;
	r1 = r0.w * r1.w + -0.0001;
	r0.x = r0.w * g_MatrialColor.w;
	o.w = r0.x;
	clip(r1);

	return o;
}
