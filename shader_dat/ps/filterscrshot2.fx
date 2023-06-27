sampler g_Sampler0;
float g_add_alpha;
float g_color_saido;
float g_tone_ed;
float g_tone_st;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float3 r2;
	r0 = tex2D(g_Sampler0, texcoord);
	r1.x = dot(r0.xyz, 0.298912);
	r1.y = r1.x * g_add_alpha.x;
	r1.y = r1.y * 0.5;
	r2.xyz = float3(0.25, 0.75, 1);
	r1.zw = r2.xy * g_add_alpha.xx;
	r2.x = r1.x + -0.5;
	r1.z = r2.x * r1.w + r1.z;
	r1.y = (r2.x >= 0) ? r1.z : r1.y;
	r0.w = r0.w + r1.y;
	o.w = min(r0.w, 1);
	r0.w = r2.z + -g_color_saido.x;
	r2.xyz = lerp(r1.xxx, r0.xyz, r0.www);
	r0.xyz = min(r2.xyz, 1);
	r1.x = g_tone_st.x;
	r0.w = -r1.x + g_tone_ed.x;
	r1.xyz = r0.www * r0.xyz;
	r0.xyz = (r0.xyz >= 0) ? r1.xyz : 0;
	r0.xyz = r0.xyz + g_tone_st.xxx;
	o.xyz = min(r0.xyz, 1);

	return o;
}
