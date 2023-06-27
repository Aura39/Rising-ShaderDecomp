float4 g_MatrialColor;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
sampler g_Sampler3;
float g_constant_range;
float g_dv_range;
float g_eff_range;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.w = -1;
	r1.x = r0.w + g_constant_range.x;
	r1.yzw = r0.xyz * r1.xxx;
	r0.x = dot(r0.xyz, 0.298912);
	r0.x = r0.x * g_constant_range.x;
	r1.xyz = (r1.xxx >= 0) ? r1.yzw : 0;
	r2 = tex2D(g_Sampler0, texcoord);
	r0.y = dot(r2.xyz, 0.298912);
	r0.z = r2.w * g_MatrialColor.x + r0.y;
	r0.z = r0.z + -g_MatrialColor.y;
	r0.z = r0.z * g_MatrialColor.w;
	r2.xyz = r0.zzz * r2.xyz;
	r0.y = r0.z * g_MatrialColor.x + r0.y;
	r0.y = r0.y + -g_MatrialColor.y;
	r0.x = r0.y * g_MatrialColor.w + r0.x;
	r1.xyz = r2.xyz * 2 + r1.xyz;
	r2 = tex2D(g_Sampler2, texcoord);
	r0.y = r0.w + g_eff_range.x;
	r3.xyz = r0.yyy * r2.xyz;
	r0.z = dot(r2.xyz, 0.298912);
	r0.x = r0.z * g_eff_range.x + r0.x;
	r2.xyz = (r0.yyy >= 0) ? r3.xyz : 0;
	r1.xyz = r1.xyz + r2.xyz;
	r2 = tex2D(g_Sampler3, texcoord);
	r0.y = r0.w + g_dv_range.x;
	r3.xyz = r0.yyy * r2.xyz;
	r0.z = dot(r2.xyz, 0.298912);
	o.w = r0.z * g_dv_range.x + r0.x;
	r0.xyz = (r0.yyy >= 0) ? r3.xyz : 0;
	o.xyz = r0.xyz + r1.xyz;

	return o;
}
